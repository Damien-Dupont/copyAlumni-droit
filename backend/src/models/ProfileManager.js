const AbstractManager = require("./AbstractManager");

class ProfileManager extends AbstractManager {
  static table = "profile";

  andOrWhere(sqlQueryToTest) {
    return sqlQueryToTest.includes("WHERE") ? " AND" : " WHERE";
  }

  findAll(query) {
    // SELECT lastname, firstname, P.id, U.is_valid, photo FROM profile as P        INNER JOIN user as U ON P.id = U.id  INNER JOIN profession as W ON P.profession_id = W.id INNER JOIN profile_diplome as PD ON PD.profile_id = P.id INNER JOIN diplome as D ON PD.diplome_id = D.id WHERE U.is_valid = 1 AND PD.diplome_id > 1 AND year > 1900 AND P.profession_id >1 LIMIT 30;

    const { diplome, promo, job, nomPrenom } = query;
    let sqlQuery = `SELECT lastname, firstname, P.id, U.is_valid, photo FROM ${ProfileManager.table} as P`;
    const sqlValue = [];

    sqlQuery += ` INNER JOIN user as U ON P.id = U.id`;

    sqlQuery += ` INNER JOIN profession as W ON P.profession_id = W.id`;

    if (diplome || promo) {
      sqlQuery += ` INNER JOIN profile_diplome as PD ON PD.profile_id = P.id`;
      sqlQuery += ` INNER JOIN diplome as D ON PD.diplome_id = D.id`;
    }

    sqlQuery += ` ${this.andOrWhere(sqlQuery)} U.is_valid = 1`;

    if (diplome) {
      sqlQuery += `${this.andOrWhere(sqlQuery)} PD.diplome_id = ?`;
      sqlValue.push(`${diplome}`);
    }
    if (promo) {
      sqlQuery += `${this.andOrWhere(sqlQuery)} year = ?`;
      sqlValue.push(`${promo}`);
    }
    if (job) {
      sqlQuery += ` ${this.andOrWhere(sqlQuery)} P.profession_id = ?`;
      sqlValue.push(`${job}`);
    }
    if (nomPrenom) {
      sqlQuery += `${this.andOrWhere(
        sqlQuery
      )} P.firstname LIKE ? OR P.lastname LIKE ?`;
      sqlValue.push(`%${nomPrenom}%`, `%${nomPrenom}%`);
    }

    sqlQuery += ` LIMIT 30`;

    return this.connection.query(sqlQuery, sqlValue).then((res) => res[0]);
  }

  findMyProfile(id) {
    return this.connection
      .query(`select * from  ${ProfileManager.table} where user_id = ?`, [id])
      .then((res) => res[0]);
  }

  insert(user, id) {
    const date = new Date();
    return this.connection.query(
      `insert into ${ProfileManager.table} (user_id, lastname, firstname, creation_date, emailpro, phone, profession_id, employeur, poste, bio, siteweb, facebook, linkedin, twitter, instagram) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        id,
        user.lastname,
        user.firstname,
        `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`,
        user.emailpro,
        user.phone,
        user.profession_id,
        user.employeur,
        user.poste,
        user.bio,
        user.siteweb,
        user.facebook,
        user.linkedin,
        user.twitter,
        user.instagram,
      ]
    );
  }

  countAll() {
    return this.connection
      .query(
        `SELECT COUNT(*) as n FROM ${ProfileManager.table} INNER JOIN user ON user.id = ${ProfileManager.table}.user_id WHERE is_valid = true`
      )
      .then((res) => res[0][0].n);
  }

  update(item) {
    return this.connection.query(
      `update ${ProfileManager.table} set title = ? where id = ?`,
      [item.title, item.id]
    );
  }
}

module.exports = ProfileManager;
