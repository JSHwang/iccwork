module.exports = function(sequelize, DataTypes) {
    var Student = sequelize.define('Student', {
        term: {
            type: DataTypes.INTEGER(2),
            allowNull: false,
            defaultValue: 1,
            comment: '학생의 학기'
        },
        status: {
            type: DataTypes.INTEGER(1),
            allowNull: false,
            defaultValue: 0,
            comment: '0은 재학, 1은 휴학, 2는 수료, 3은 졸업'
        },
        title: {
            type: DataTypes.STRING,
            defaultValue: '',
            comment: '작품/논문 제목'
        },
        iswork: {
            type: DataTypes.BOOLEAN,
            allowNull: false,
            defaultValue: 0,
            comment: '논문(0) or 작품(1)'
        },
        isgroup: {
            type: DataTypes.BOOLEAN,
            allowNull: false,
            defaultValue: 0,
            comment: '개인(0) or 공동(1)'
        },
        result: {
            type: DataTypes.INTEGER(1),
            allowNull: false,
            defaultValue: 0,
            comment: '심사 (0 : 미심사, 1 : 심사통과, 2 : 심사탈락, 3 : 기합격)'
        },
        isdisplay: {
            type: DataTypes.INTEGER(1),
            allowNull: false,
            defaultValue: 0,
            comment: '심사 결과 출력 여부'
        },
        note: {
            type: DataTypes.TEXT,
            defaultValue: '',
            comment: '메모'
        },
        comment: {
            type: DataTypes.TEXT,
            defaultValue: '',
            comment: '비고'
        },
        gryearterm: {
            type: DataTypes.STRING(10),
            comment: '졸업 예정 학기'
        },
        islock: {
            type: DataTypes.BOOLEAN,
            allowNull: false,
            defaultValue: 0,
            comment: '시스템 진행 락'
        },
        yearterm: {
            type: DataTypes.STRING(10),
            comment: '교수 배정 년도 및 학기'
        },
        time: {
            type: DataTypes.DATE,
            allowNull: false
        },
        ip: {
            type: DataTypes.STRING(127),
            allowNull: false
        }
    }, {
        tableName: 'iccsys_work_student',
        comment: '학생 정보',
        classMethods: {
            associate: function(models) {
                Student.belongsTo(models.User);
                Student.belongsTo(models.Prof);
                Student.belongsTo(models.System);
                Student.belongsTo(models.StudentInfo);
                Student.hasMany(models.Permission);
                Student.belongsTo(models.StudentFile, {
                    as: 'oath'
                });
                Student.belongsTo(models.StudentFile, {
                    as: 'proposal'
                });
                Student.belongsTo(models.StudentFile, {
                    as: 'midreport'
                });
                Student.belongsTo(models.StudentFile, {
                    as: 'finalreport'
                });
                Student.belongsTo(models.StudentFile, {
                    as: 'paperwork'
                });
                Student.belongsTo(models.StudentFile, {
                    as: 'presentation'
                });
                Student.belongsTo(models.StudentFile, {
                    as: 'conference'
                });                
            }
        }
    });
    return Student;
};