module.exports = function(sequelize, DataTypes) {
    var System = sequelize.define('System', {
        phase: {
            type: DataTypes.STRING,
            defaultValue: ''
        },
        start: {
            type: DataTypes.DATE,
            allowNull: false,
            comment: '시작 날짜'
        },
        end: {
            type: DataTypes.DATE,
            allowNull: false,
            comment: '종료 날짜'
        }
    }, {
        tableName: 'iccsys_work_system',
        comment: '시스템 단계',
        classMethods: {
            associate: function(models) {
                System.hasMany(models.Student);
            }
        }
    });
    return System;
};