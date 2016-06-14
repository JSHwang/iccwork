var config = require('../../config/config.json')[process.env.NODE_ENV || "development"];
var models = require('../../models/iccsys_work');
var models_ = require('../../models/iccsys');
var express = require('express');
var router = express.Router();
var fs = require('fs');
var async = require('async');
var sha256 = require('sha256');
var moment = require('moment');
var mkdirp = require('mkdirp');
var path = require('path');

// 로그인 인증 예외 처리
router.all('*', function(req, res, next) {
    if (process.env.NODE_ENV == 'development') { // 개발자 모드 관리자 바로 로그인 처리
        models.User.findOne({
            where: {
                ids: '2012310062'
            }
        }).then(function(user) {
            if (user !== null) {
                req.session.user = user;
            }
            next();
        });
    } else {
        if (req.session.user.type === 2) next();
        else res.redirect('/iccsys/login');
    }
});

// 페이지 리다이렉션 예외 처리
router.get('/', function(req, res, next) {
    res.redirect('/iccsys/work/student/main');
});

router.get('/main', function(req, res, next) {
    models.User.findOne({
        where: {
            id: req.session.user.id,
            type: 2
        },
        include: [{
            model: models.Student,
            include: [
                models.System,
                models.StudentInfo, {
                    model: models.Prof,
                    include: [models.User]
                }, {
                    model: models.StudentFile,
                    as: 'oath'
                }, {
                    model: models.StudentFile,
                    as: 'proposal'
                }, {
                    model: models.StudentFile,
                    as: 'midreport'
                }, {
                    model: models.StudentFile,
                    as: 'finalreport'
                }, {
                    model: models.StudentFile,
                    as: 'paperwork'
                }, {
                    model: models.StudentFile,
                    as: 'presentation'
                }, {
                    model: models.StudentFile,
                    as: 'conference'
                }
            ]
        }]
    }).then(function(user) {
        if (user !== null) {
            models.System.findAll().then(function(systems) {
                systems.forEach(function(system) {
                    system.start_ = moment(system.start).format("YYYY-MM-DD");
                    system.end_ = moment(system.end).format("YYYY-MM-DD");
                    system.start__ = moment(system.start).format("YYYY년 M월 D일");
                    system.end__ = moment(system.end).format("YYYY년 M월 D일");
                    system.isUnder = ((new Date()) < system.start);
                    system.isNow = ((new Date()) > system.start && (new Date()) < system.end);
                    system.isOver = ((new Date()) > system.end);
                });
                ["oath", "proposal", "midreport", "finalreport", "paperwork", "presentation", "conference"].forEach(function(index) {
                    if (user.Student[index]) user.Student[index].link = '/iccsys/work/ajax/file/download/' + index + '/' + user.Student[index].path.split("\\").reverse()[0].split("/").reverse()[0];
                });
                if (user.Student.StudentInfo) user.Student.StudentInfo.time_ = moment(user.Student.StudentInfo.time).format("YYYY년 M월 D일");

                models_.UserLog.findAll({
                    where: {
                        ids: req.session.user.ids
                    },
                    order: 'time desc',
                    limit: 5
                }).then(function(userLog) {
                    userLog.forEach(function(log) {
                        log.time_ = moment(log.time).format("YYYY-MM-DD HH:mm:ss");
                    });
                    res.render('iccsys/work/student/main', {
                        user: user,
                        student: user.Student,
                        prof: user.Student.Prof,
                        system: user.Student.System,
                        systems: systems,
                        loginLog: userLog
                    });
                });
            });
        } else next();
    });
});

//------------------------------------------------------------------------------------------
// 진행 페이지 라우팅 구현
router.get('/system', function(req, res, next) {
    models.User.findOne({
        where: {
            id: req.session.user.id,
            type: 2
        },
        include: [{
            model: models.Student,
            include: [
                models.System,
                models.StudentInfo, {
                    model: models.StudentFile,
                    as: 'oath'
                }, {
                    model: models.StudentFile,
                    as: 'proposal'
                }, {
                    model: models.StudentFile,
                    as: 'midreport'
                }, {
                    model: models.StudentFile,
                    as: 'finalreport'
                }, {
                    model: models.StudentFile,
                    as: 'paperwork'
                }, {
                    model: models.StudentFile,
                    as: 'presentation'
                }, {
                    model: models.StudentFile,
                    as: 'conference'
                }
            ]
        }]
    }).then(function(user) {
        if (user !== null) {
            if (user.Student.status === 0 || user.Student.status === 2) {
                if (user.Student.islock) {
                    res.render('iccsys/work/student/system_term_lock', {
                        user: user
                    });
                } else if ((new Date()) < user.Student.System.start || (new Date()) > user.Student.System.end) { // 현재 단계의 기간이 아님
                    res.render('iccsys/work/student/system_out_date', {
                        user: user
                    });
                } else {
                    ["oath", "proposal", "midreport", "finalreport", "paperwork", "presentation", "conference"].forEach(function(index) {
                        if (user.Student[index]) user.Student[index].link = '/iccsys/work/ajax/file/download/' + index + '/' + user.Student[index].path.split("\\").reverse()[0].split("/").reverse()[0];
                    });
                    user.Student.System.dataValues.start = moment(user.Student.System.start).format("YYYY-MM-DD");
                    user.Student.System.dataValues.end = moment(user.Student.System.end).format("YYYY-MM-DD");
                    res.render('iccsys/work/student/system_phase_' + user.Student.System.id, {
                        user: user,
                        student: user.Student,
                        system: user.Student.System,
                    });
                }
            } else if (user.Student.status === 1) { // 휴학생 페이지
                res.render('iccsys/work/student/system_status_1');
            } else if (user.Student.status === 0) { // 13 단계 재학 학생
                res.render('iccsys/work/student/system_phase_13');
            } else { // 13 단계 졸업 학생
                res.render('iccsys/work/student/system_phase_13_gr');
            }
        } else next();
    });
});
router.get('/system/application', function(req, res, next) {
    models.User.findOne({
        where: {
            id: req.session.user.id,
            type: 2
        },
        include: [{
            model: models.Student,
            include: [models.StudentInfo]
        }]
    }).then(function(user) {
        if (user && user.Student && user.Student.StudentInfo) {
            user.Student.StudentInfo.dataValues.time = moment(user.Student.StudentInfo.time).format("YYYY년 M월 D일");
            console.log(user.Student);
            res.render('iccsys/work/student/system_phase_2_view', {
                user: user,
                student: user.Student
            });
        } else next();
    });
});

// 신청서 제출 처리 페이지
router.post('/system/proc/application', function(req, res, next) {
    console.log(req.body);
    models.User.findOne({
        where: {
            id: req.session.user.id,
            type: 2
        },
        include: [{
            model: models.Student,
            include: [models.StudentInfo]
        }]
    }).then(function(user) {
        if (user && user.Student) {
            req.body.UserId = user.id; // 보안상
            if (user.Student.StudentInfo) {
                user.Student.StudentInfo.updateAttributes(req.body).then(function(studentinfo) {
                    res.send({
                        result: true
                    });
                });
            } else {
                user.Student.createStudentInfo(req.body).then(function(studentinfo) {
                    res.send({
                        result: true
                    });
                });
            }
        } else next();
    });
});

// 희망 교수 선택 ajax 요청 처리
router.all('/system/ajax/permission', function(req, res, next) {
    models.User.findOne({
        where: {
            id: req.session.user.id,
            type: 2
        },
        include: [{
            model: models.Student,
            include: [models.System]
        }]
    }).then(function(user) {
        if (user !== null) {
            /*
            // Sequelize아래 경우 student * firstPermissions * secondPermissions * thirdPermissions 갯수만큼 가져와서 합치는 거라
            // 부하가 엄청 심함 (Sequelize가 join을 outer로해서 통합하는듯...)
            models.User.findAll({
                order: 'name',
                where: {
                    type: 1
                },
                include: [{
                    model: models.Prof,
                    include: [{
                        model: models.Student, // 이건 선택된거
                    }, {
                        model: models.Permission, // 1차 선택된거
                        as: 'firstPermissions'
                    }, {
                        model: models.Permission, // 2차 선택된거
                        as: 'secondPermissions'
                    }, {
                        model: models.Permission, // 3차 선택된거
                        as: 'thirdPermissions'
                    }]
                }]
            }).then(function(users) { // 교수 리스트
                var yearterm = (new Date()).getFullYear().toString() + ((new Date()).getMonth() < 6 ? "01" : "02");
                var order = parseInt((parseInt(user.Student.System.id) - 1) / 2);
                var data = [];
                users.forEach(function(user) {
                    ['Students', 'firstPermissions', 'secondPermissions', 'thirdPermissions'].forEach(function(index) {
                        user.Prof[index] = user.Prof[index].filter(function(permission) {
                            if (index == 'Students' && permission.yearterm == yearterm) return true;
                            else if (permission.yearterm == yearterm && permission.order == order && permission.ProfId === null) return true;
                            else return false;
                        });
                    });
                    data.push({
                        id: user.Prof.id,
                        name: user.name,
                        major: user.major,
                        selectable: (config.iccsys.permit_student_count - user.Prof.Students.length < 0 ? 0 : config.iccsys.permit_student_count - user.Prof.Students.length),
                        firstSelected: user.Prof.firstPermissions.length,
                        secondSelected: user.Prof.secondPermissions.length,
                        thirdSelected: user.Prof.thirdPermissions.length
                    });
                });
                models.Permission.findOne({
                    where: {
                        StudentId: user.Student.id,
                        yearterm: yearterm,
                        order: order
                    }
                }).then(function(permission) { // 자기 정보
                    if (permission !== null) {
                        res.send({
                            data: data,
                            selected: permission
                        });
                    } else {
                        res.send({
                            data: data,
                            selected: null
                        });
                    }
                });
            });
            */
            models.User.findAll({
                order: 'name',
                where: {
                    type: 1
                },
                include: [{
                    model: models.Prof
                }]
            }).then(function(users) {
                var yearterm = (new Date()).getFullYear().toString() + ((new Date()).getMonth() < 6 ? "01" : "02");
                var order = parseInt((parseInt(user.Student.System.id) - 1) / 2);
                var data = [];

                async.each(users, function(user, callback) {
                    async.series({
                        selected: function(callback){
                            models.Student.count({
                                where: {
                                    ProfId : user.Prof.id,
                                    yearterm : yearterm,
                                }
                            }).then(function(result){
                                callback(null,result);
                            });
                        },
                        firstSelected: function(callback){
                            models.Permission.count({
                                where: {
                                    firstProfId: user.Prof.id,
                                    yearterm : yearterm,                                    
                                    order : order,
                                    ProfId : null
                                }
                            }).then(function(result){
                                callback(null,result);
                            });
                        },
                        secondSelected: function(callback){
                            models.Permission.count({
                                where: {
                                    secondProfId : user.Prof.id,
                                    yearterm : yearterm,                                    
                                    order : order,
                                    ProfId : null
                                }
                            }).then(function(result){
                                callback(null,result);
                            });
                        },
                        thirdSelected: function(callback){
                            models.Permission.count({
                                where: {
                                    thirdProfId : user.Prof.id,
                                    yearterm : yearterm,                                    
                                    order : order,
                                    ProfId : null
                                }
                            }).then(function(result){
                                callback(null,result);
                            });
                        }
                    },
                    function(err, results) {
                        console.log(results);
                        data.push({
                            id: user.Prof.id,
                            name: user.name,
                            major: user.major,
                            selectable: (config.iccsys.permit_student_count - results.selected < 0 ? 0 : config.iccsys.permit_student_count - results.selected),
                            firstSelected: results.firstSelected,
                            secondSelected: results.secondSelected,
                            thirdSelected: results.thirdSelected
                        });
                        callback();
                    });
                }, function(err){
                    models.Permission.findOne({
                        where: {
                            StudentId: user.Student.id,
                            yearterm: yearterm,
                            order: order
                        }
                    }).then(function(permission) { // 자기 정보
                        if (permission !== null) {
                            res.send({
                                data: data,
                                selected: permission
                            });
                        } else {
                            res.send({
                                data: data,
                                selected: null
                            });
                        }
                    });
                });
            });            
        } else next();
    });
});
// 희망교수 선택 처리 페이지
router.post('/system/proc/permission', function(req, res, next) {
    models.User.findOne({
        where: {
            id: req.session.user.id,
            type: 2
        },
        include: [{
            model: models.Student,
            include: [models.System]
        }]
    }).then(function(user) {
        if (user !== null) {
            if ((user.Student.System.id == 3 || user.Student.System.id == 5 || user.Student.System.id == 7) && ((new Date()) > user.Student.System.start && (new Date()) < user.Student.System.end)) {
                if (req.body.firstProfId != req.body.secondProfId && req.body.firstProfId != req.body.thirdProfId && req.body.secondProfId != req.body.thirdProfId) {
                    var yearterm = (new Date()).getFullYear().toString() + ((new Date()).getMonth() < 6 ? "01" : "02");
                    var order = parseInt((parseInt(user.Student.System.id) - 1) / 2);
                    async.each([req.body.firstProfId, req.body.secondProfId, req.body.thirdProfId], function(id, callback) {
                        models.Prof.findOne({
                            where: {
                                id: id
                            },
                            include: [{
                                model: models.Student,
                                where: {
                                    yearterm: yearterm
                                }
                            }]
                        }).then(function(prof) { // 교수 리스트
                            if (prof !== null) {
                                if (prof.Students.length > config.iccsys.permit_student_count) callback(prof);
                                else callback();
                            } else callback();
                        });
                    }, function(err) {
                        if (err) {
                            res.send({
                                result: false,
                                text: '선택하신 교수님의 지도 가능 학생수가 부족합니다. 다시 확인해주세요.'
                            });
                        } else {
                            models.Permission.findOne({
                                where: {
                                    yearterm: yearterm,
                                    order: order, // 이거 귀찮아서 그냥 이렇게함
                                    StudentId: user.Student.id
                                }
                            }).then(function(permission) {
                                if (permission === null) { // 레코드 없을시 생성
                                    models.Permission.create({
                                        yearterm: yearterm,
                                        order: order, // 이거 귀찮아서 그냥 이렇게함
                                        firstProfId: req.body.firstProfId,
                                        secondProfId: req.body.secondProfId,
                                        thirdProfId: req.body.thirdProfId,
                                        StudentId: user.Student.id
                                    }).then(function(permission) {
                                        res.send({
                                            result: true
                                        });
                                    });
                                } else {
                                    permission.updateAttributes({
                                        firstProfId: req.body.firstProfId,
                                        secondProfId: req.body.secondProfId,
                                        thirdProfId: req.body.thirdProfId,
                                    }).then(function(permission) {
                                        res.send({
                                            result: true
                                        });
                                    });
                                }
                            });
                        }
                    });
                } else {
                    res.send({
                        result: false,
                        text: '서로다른 교수님을 선택해야합니다.'
                    });
                }
            } else {
                res.send({
                    result: false,
                    text: '희망교수 선택 기간이 아니거나, 희망교수 선택 단계가 아닙니다.'
                });
            }
        } else next();
    });
});

// 서약서 및 제안서 제출 처리 페이지
router.post('/system/proc/oath_proposal', function(req, res, next) {
    models.User.findOne({
        where: {
            id: req.session.user.id,
            type: 2
        },
        include: [{
            model: models.Student,
            include: [models.System, {
                model: models.StudentFile,
                as: 'oath'
            }, {
                model: models.StudentFile,
                as: 'proposal'
            }]
        }]
    }).then(function(user) {
        if (user !== null) {
            if (user.Student.System.id == 9 && ((new Date()) > user.Student.System.start && (new Date()) < user.Student.System.end)) {
                async.waterfall([

                    function(callback) {
                        if (req.files.oath) {
                            var file = req.files.oath;
                            if (file.isFileSizeLimit) {
                                callback(null, {
                                    result: false,
                                    text: '서약서 파일 사이즈가 초과하였습니다. ( 최대 20MB )'
                                });
                            } else {
                                var file_name = Date.now() + "-" + file.name;
                                var file_path = path.join(config.iccsys.upload_path, 'work/oath', file_name);
                                mkdirp(path.join(config.iccsys.upload_path, 'work/oath'), function(err) {
                                    if (!err) {
                                        fs.rename(file.path, file_path, function(err) {
                                            if (!err) {
                                                req.body.name = file.originalname;
                                                req.body.path = file_path;
                                                req.body.type = file.mimetype;
                                                req.body.size = file.size;
                                                user.createStudentFile(req.body).then(function(studentfile) {
                                                    if (user.Student.oathId) {
                                                        if (user.Student.oathId == 1) {
                                                            user.Student.setOath(studentfile).then(function() {
                                                                callback(null, {
                                                                    result: true,
                                                                });
                                                            });
                                                        } else {
                                                            try {
                                                                fs.unlinkSync(user.Student.oath.path);
                                                            } catch (err) {}
                                                            user.Student.oath.destroy().then(function() {
                                                                user.Student.setOath(studentfile).then(function() {
                                                                    callback(null, {
                                                                        result: true,
                                                                    });
                                                                });
                                                            });
                                                        }
                                                    } else {
                                                        user.Student.setOath(studentfile).then(function() {
                                                            callback(null, {
                                                                result: true,
                                                            });
                                                        });
                                                    }
                                                });
                                            } else {
                                                callback(null, {
                                                    result: false,
                                                    text: err
                                                });
                                            }
                                        });
                                    } else {
                                        callback(null, {
                                            result: false,
                                            text: err
                                        });
                                    }
                                });
                            }
                        } else {
                            callback(null, {
                                result: true,
                            });
                        }
                    },
                    function(result, callback) {
                        if (result.result) {
                            if (req.files.proposal) { // 위 소스코드 그대로 참조함
                                var file = req.files.proposal;
                                if (file.isFileSizeLimit) {
                                    callback(null, {
                                        result: false,
                                        text: '제안서 파일 사이즈가 초과하였습니다. ( 최대 20MB )'
                                    });
                                } else {
                                    var file_name = Date.now() + "-" + file.name;
                                    var file_path = path.join(config.iccsys.upload_path, 'work/proposal', file_name);
                                    mkdirp(path.join(config.iccsys.upload_path, 'work/proposal'), function(err) {
                                        if (!err) {
                                            fs.rename(file.path, file_path, function(err) {
                                                if (!err) {
                                                    req.body.name = file.originalname;
                                                    req.body.path = file_path;
                                                    req.body.type = file.mimetype;
                                                    req.body.size = file.size;
                                                    user.createStudentFile(req.body).then(function(studentfile) {
                                                        if (user.Student.proposalId) {
                                                            if (user.Student.proposalId == 1) {
                                                                user.Student.setProposal(studentfile).then(function() {
                                                                    callback(null, {
                                                                        result: true,
                                                                    });
                                                                });
                                                            } else {
                                                                try {
                                                                    fs.unlinkSync(user.Student.proposal.path);
                                                                } catch (err) {}
                                                                user.Student.proposal.destroy().then(function() {
                                                                    user.Student.setProposal(studentfile).then(function() {
                                                                        callback(null, {
                                                                            result: true,
                                                                        });
                                                                    });
                                                                });
                                                            }
                                                        } else {
                                                            user.Student.setProposal(studentfile).then(function() {
                                                                callback(null, {
                                                                    result: true,
                                                                });
                                                            });
                                                        }
                                                    });
                                                } else {
                                                    callback(null, {
                                                        result: false,
                                                        text: err
                                                    });
                                                }
                                            });
                                        } else {
                                            callback(null, {
                                                result: false,
                                                text: err
                                            });
                                        }
                                    });
                                }
                            } else {
                                callback(null, {
                                    result: true,
                                });
                            }
                        } else {
                            callback(null, result);
                        }
                    }
                ], function(err, result) {
                    try {
                        fs.unlinkSync(req.files.oath.path);
                    } catch (err) {}
                    try {
                        fs.unlinkSync(req.files.proposal.path);
                    } catch (err) {}
                    if (result.result) {
                        user.Student.updateAttributes({
                            title: req.body.title,
                            iswork: req.body.iswork,
                            isgroup: req.body.isgroup
                        }).then(function() {
                            res.send(result);
                        });
                    } else res.send(result);
                });
            } else {
                res.send({
                    result: false,
                    text: '서약서 및 제안서 제출 기간이 아니거나, 서약서 및 제안서 제출 단계가 아닙니다.'
                });
            }
        } else next();
    });
});
// 중간보고서 처리 페이지 (신청서 제출 코드 그대로 사용)
router.post('/system/proc/midreport', function(req, res, next) {
    models.User.findOne({
        where: {
            id: req.session.user.id,
            type: 2
        },
        include: [{
            model: models.Student,
            include: [models.System, {
                model: models.StudentFile,
                as: 'midreport'
            }]
        }]
    }).then(function(user) {
        if (user !== null) {
            if (user.Student.System.id == 10 && ((new Date()) > user.Student.System.start && (new Date()) < user.Student.System.end)) {
                var file = req.files.midreport;
                if (file.isFileSizeLimit) {
                    res.send({
                        result: false,
                        text: '파일 사이즈가 초과하였습니다. ( 최대 20MB )'
                    });
                } else {
                    var file_name = Date.now() + "-" + file.name;
                    var file_path = path.join(config.iccsys.upload_path, 'work/midreport', file_name);
                    mkdirp(path.join(config.iccsys.upload_path, 'work/midreport'), function(err) {
                        if (!err) {
                            fs.rename(file.path, file_path, function(err) {
                                if (!err) {
                                    req.body.name = file.originalname;
                                    req.body.path = file_path;
                                    req.body.type = file.mimetype;
                                    req.body.size = file.size;
                                    user.createStudentFile(req.body).then(function(studentfile) {
                                        if (user.Student.midreportId) {
                                            try {
                                                fs.unlinkSync(user.Student.midreport.path);
                                            } catch (err) {}
                                            user.Student.midreport.destroy().then(function() {
                                                user.Student.setMidreport(studentfile).then(function() {
                                                    res.send({
                                                        result: true,
                                                    });
                                                });
                                            });
                                        } else {
                                            user.Student.setMidreport(studentfile).then(function() {
                                                res.send({
                                                    result: true,
                                                });
                                            });
                                        }
                                    });
                                } else {
                                    next(err);
                                }
                            });
                        } else {
                            next(err);
                        }
                    });
                }
            } else {
                try {
                    fs.unlinkSync(req.files.midreport.path);
                } catch (err) {}
                res.send({
                    result: false,
                    text: '신청서 제출 기간이 아니거나, 신청서 제출 단계가 아닙니다.'
                });
            }
        } else next();
    });
});
// 최종보고서 및 논문/작품, 발표자료 제출 처리 페이지 (서약서 및 제안서 제출 처리 페이지 코드 사용)
router.post('/system/proc/final_etc', function(req, res, next) {
    models.User.findOne({
        where: {
            id: req.session.user.id,
            type: 2
        },
        include: [{
            model: models.Student,
            include: [models.System, {
                model: models.StudentFile,
                as: 'finalreport'
            }, {
                model: models.StudentFile,
                as: 'paperwork'
            }, {
                model: models.StudentFile,
                as: 'presentation'
            }, {
                model: models.StudentFile,
                as: 'conference'
            }]
        }]
    }).then(function(user) {
        if (user !== null) {
            if (user.Student.System.id == 11 && ((new Date()) > user.Student.System.start && (new Date()) < user.Student.System.end)) {
                async.waterfall([

                    function(callback) {
                        if (req.files.finalreport) {
                            var file = req.files.finalreport;
                            if (file.isFileSizeLimit) {
                                callback(null, {
                                    result: false,
                                    text: '최종보고서 파일 사이즈가 초과하였습니다. ( 최대 20MB )'
                                });
                            } else {
                                var file_name = Date.now() + "-" + file.name;
                                var file_path = path.join(config.iccsys.upload_path, 'work/finalreport', file_name);
                                mkdirp(path.join(config.iccsys.upload_path, 'work/finalreport'), function(err) {
                                    if (!err) {
                                        fs.rename(file.path, file_path, function(err) {
                                            if (!err) {
                                                req.body.name = file.originalname;
                                                req.body.path = file_path;
                                                req.body.type = file.mimetype;
                                                req.body.size = file.size;
                                                user.createStudentFile(req.body).then(function(studentfile) {
                                                    if (user.Student.finalreportId) {
                                                        try {
                                                            fs.unlinkSync(user.Student.finalreport.path);
                                                        } catch (err) {}
                                                        user.Student.finalreport.destroy().then(function() {
                                                            user.Student.setFinalreport(studentfile).then(function() {
                                                                callback(null, {
                                                                    result: true,
                                                                });
                                                            });
                                                        });
                                                    } else {
                                                        user.Student.setFinalreport(studentfile).then(function() {
                                                            callback(null, {
                                                                result: true,
                                                            });
                                                        });
                                                    }
                                                });
                                            } else {
                                                callback(null, {
                                                    result: false,
                                                    text: err
                                                });
                                            }
                                        });
                                    } else {
                                        callback(null, {
                                            result: false,
                                            text: err
                                        });
                                    }
                                });
                            }
                        } else {
                            callback(null, {
                                result: true,
                            });
                        }
                    },
                    function(result, callback) {
                        if (result.result) {
                            if (req.files.paperwork) { // 위 소스코드 그대로 참조함
                                var file = req.files.paperwork;
                                if (file.isFileSizeLimit) {
                                    callback(null, {
                                        result: false,
                                        text: '논문/작품 파일 사이즈가 초과하였습니다. ( 최대 20MB )'
                                    });
                                } else {
                                    var file_name = Date.now() + "-" + file.name;
                                    var file_path = path.join(config.iccsys.upload_path, 'work/paperwork', file_name);
                                    mkdirp(path.join(config.iccsys.upload_path, 'work/paperwork'), function(err) {
                                        if (!err) {
                                            fs.rename(file.path, file_path, function(err) {
                                                if (!err) {
                                                    req.body.name = file.originalname;
                                                    req.body.path = file_path;
                                                    req.body.type = file.mimetype;
                                                    req.body.size = file.size;
                                                    user.createStudentFile(req.body).then(function(studentfile) {
                                                        if (user.Student.paperworkId) {
                                                            try {
                                                                fs.unlinkSync(user.Student.paperwork.path);
                                                            } catch (err) {}
                                                            user.Student.paperwork.destroy().then(function() {
                                                                user.Student.setPaperwork(studentfile).then(function() {
                                                                    callback(null, {
                                                                        result: true,
                                                                    });
                                                                });
                                                            });
                                                        } else {
                                                            user.Student.setPaperwork(studentfile).then(function() {
                                                                callback(null, {
                                                                    result: true,
                                                                });
                                                            });
                                                        }
                                                    });
                                                } else {
                                                    callback(null, {
                                                        result: false,
                                                        text: err
                                                    });
                                                }
                                            });
                                        } else {
                                            callback(null, {
                                                result: false,
                                                text: err
                                            });
                                        }
                                    });
                                }
                            } else {
                                callback(null, {
                                    result: true,
                                });
                            }
                        } else {
                            callback(null, result);
                        }
                    },
                    function(result, callback) {
                        if (result.result) {
                            if (req.files.presentation) { // 위 소스코드 그대로 참조함
                                var file = req.files.presentation;
                                if (file.isFileSizeLimit) {
                                    callback(null, {
                                        result: false,
                                        text: '발표자료 파일 사이즈가 초과하였습니다. ( 최대 20MB )'
                                    });
                                } else {
                                    var file_name = Date.now() + "-" + file.name;
                                    var file_path = path.join(config.iccsys.upload_path, 'work/presentation', file_name);
                                    mkdirp(path.join(config.iccsys.upload_path, 'work/presentation'), function(err) {
                                        if (!err) {
                                            fs.rename(file.path, file_path, function(err) {
                                                if (!err) {
                                                    req.body.name = file.originalname;
                                                    req.body.path = file_path;
                                                    req.body.type = file.mimetype;
                                                    req.body.size = file.size;
                                                    user.createStudentFile(req.body).then(function(studentfile) {
                                                        if (user.Student.presentationId) {
                                                            try {
                                                                fs.unlinkSync(user.Student.presentation.path);
                                                            } catch (err) {}
                                                            user.Student.presentation.destroy().then(function() {
                                                                user.Student.setPresentation(studentfile).then(function() {
                                                                    callback(null, {
                                                                        result: true,
                                                                    });
                                                                });
                                                            });
                                                        } else {
                                                            user.Student.setPresentation(studentfile).then(function() {
                                                                callback(null, {
                                                                    result: true,
                                                                });
                                                            });
                                                        }
                                                    });
                                                } else {
                                                    callback(null, {
                                                        result: false,
                                                        text: err
                                                    });
                                                }
                                            });
                                        } else {
                                            callback(null, {
                                                result: false,
                                                text: err
                                            });
                                        }
                                    });
                                }
                            } else {
                                callback(null, {
                                    result: true,
                                });
                            }
                        } else {
                            callback(null, result);
                        }
                    },
                    function(result, callback) {
                        if (result.result) {
                            if (req.files.conference) { // 위 소스코드 그대로 참조함
                                var file = req.files.conference;
                                if (file.isFileSizeLimit) {
                                    callback(null, {
                                        result: false,
                                        text: '발표자료 파일 사이즈가 초과하였습니다. ( 최대 20MB )'
                                    });
                                } else {
                                    var file_name = Date.now() + "-" + file.name;
                                    var file_path = path.join(config.iccsys.upload_path, 'work/conference', file_name);
                                    mkdirp(path.join(config.iccsys.upload_path, 'work/conference'), function(err) {
                                        if (!err) {
                                            fs.rename(file.path, file_path, function(err) {
                                                if (!err) {
                                                    req.body.name = file.originalname;
                                                    req.body.path = file_path;
                                                    req.body.type = file.mimetype;
                                                    req.body.size = file.size;
                                                    user.createStudentFile(req.body).then(function(studentfile) {
                                                        if (user.Student.conferenceId) {
                                                            try {
                                                                fs.unlinkSync(user.Student.conference.path);
                                                            } catch (err) {}
                                                            user.Student.conference.destroy().then(function() {
                                                                user.Student.setConference(studentfile).then(function() {
                                                                    callback(null, {
                                                                        result: true,
                                                                    });
                                                                });
                                                            });
                                                        } else {
                                                            user.Student.setConference(studentfile).then(function() {
                                                                callback(null, {
                                                                    result: true,
                                                                });
                                                            });
                                                        }
                                                    });
                                                } else {
                                                    callback(null, {
                                                        result: false,
                                                        text: err
                                                    });
                                                }
                                            });
                                        } else {
                                            callback(null, {
                                                result: false,
                                                text: err
                                            });
                                        }
                                    });
                                }
                            } else {
                                callback(null, {
                                    result: true,
                                });
                            }
                        } else {
                            callback(null, result);
                        }
                    }
                ], function(err, result) {
                    try {
                        fs.unlinkSync(req.files.finalreport.path);
                    } catch (err) {}
                    try {
                        fs.unlinkSync(req.files.paperwork.path);
                    } catch (err) {}
                    try {
                        fs.unlinkSync(req.files.presentation.path);
                    } catch (err) {}
                    try {
                        fs.unlinkSync(req.files.conference.path);
                    } catch (err) {}
                    if (result.result) {
                        user.Student.updateAttributes({
                            title: req.body.title,
                            iswork: req.body.iswork,
                            isgroup: req.body.isgroup
                        }).then(function() {
                            res.send(result);
                        });
                    } else res.send(result);
                });
            } else {
                res.send({
                    result: false,
                    text: '최종보고서 및 논문/작품, 발표자료 제출 기간이 아니거나, 제출 단계가 아닙니다.'
                });
            }
        } else next();
    });
});

//------------------------------------------------------------------------------------------
// 회원정보 수정
router.get('/config', function(req, res, next) {
    models.User.findOne(req.session.user.id).then(function(user) {
        if (user !== null) {
            res.render('iccsys/work/student/config', {
                user: user
            });
        } else next();
    });
});
router.post('/config', function(req, res, next) {
    models.User.findOne(req.session.user.id).then(function(user) {
        if (user !== null) {
            var tmp = {
                email: req.body.email,
                phone: req.body.phone,
                time: new Date(),
                ip: req.ip
            };
            if (req.body.password !== "") tmp.password = sha256(req.body.password);
            user.updateAttributes(tmp).then(function(user) {
                res.send({
                    result: true
                });
            });
        } else next();
    });
});

//------------------------------------------------------------------------------------------
// 학생 공지사항 부분 추가
router.get('/notice', function(req, res, next) {
    res.redirect('/iccsys/work/student/notice/list');
});
router.get('/notice/list', function(req, res, next) {
    res.render('iccsys/work/student/notice_list');
});
router.get('/notice/view/:id', function(req, res, next) {
    res.render('iccsys/work/student/notice_view', {
        id: req.params.id
    });
});

//------------------------------------------------------------------------------------------
router.get('/example', function(req, res, next) {
    res.redirect('/iccsys/work/student/example/list');
});
router.get('/example/list', function(req, res, next) {
    res.render('iccsys/work/student/example_list');
});
router.get('/example/view/:id', function(req, res, next) {
    res.render('iccsys/work/student/example_view', {
        id: req.params.id
    });
});

//------------------------------------------------------------------------------------------
// 질문 및 답변 게시판 추가 (admin.js 소스 복붙후 수정)
router.get('/qna', function(req, res, next) {
    res.redirect('/iccsys/work/student/qna/list');
});
router.get('/qna/list', function(req, res, next) {
    res.render('iccsys/work/student/qna_list');
});
router.get('/qna/write', function(req, res, next) {
    res.render('iccsys/work/student/qna_write');
});
router.get('/qna/view/:id', function(req, res, next) {
    res.render('iccsys/work/student/qna_view', {
        id: req.params.id
    });
});
router.get('/qna/reply/:id', function(req, res, next) {
    res.render('iccsys/work/student/qna_reply', {
        id: req.params.id
    });
});
router.get('/qna/modify/:id', function(req, res, next) {
    res.render('iccsys/work/student/qna_modify', {
        id: req.params.id
    });
});
module.exports = router;