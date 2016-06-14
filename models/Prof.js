module.exports = function(sequelize, DataTypes) {
    var Prof = sequelize.define('Prof', {
    }, {
        tableName: 'iccsys_work_prof',
        classMethods: {
            associate: function(models) {
                Prof.belongsTo(models.User);
                Prof.hasMany(models.Student);
                Prof.hasMany(models.Permission);
                Prof.hasMany(models.Permission, {
                    as: 'firstPermissions',
                    foreignKey : 'firstProfId'
                });
                Prof.hasMany(models.Permission, {
                    as: 'secondPermissions',
                    foreignKey : 'secondProfId'
                });
                Prof.hasMany(models.Permission, {
                    as: 'thirdPermissions',
                    foreignKey : 'thirdProfId'
                });                
            }
        }
    });
    return Prof;
};