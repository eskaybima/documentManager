package com.fasyl.Dao;

//import com.LasrraCenRep.util.ConnectionManager;
//import com.fasyl.util.Encryption;
//import com.fasyl.vo.UserVo;
//import java.io.PrintStream;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;
//import java.sql.Timestamp;
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.List;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//
//public class UserDao {
//
//    private Connection conn;
//
//    public UserDao() {
//        conn = ConnectionManager.getInstance().getConnection();
//    }
//  /*`user_id` varchar(15) NOT NULL DEFAULT '',
//  `user_name` varchar(15) DEFAULT NULL,
//  `password` varchar(20) DEFAULT NULL,
//  `first_name` varchar(15) DEFAULT NULL,
//  `middle_name` varchar(15) DEFAULT NULL,
//  `last_name` varchar(15) DEFAULT NULL,
//  `cre_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
//  `last_login_dt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
//  `user_loc_id` varchar(10) DEFAULT NULL,
//  `user_role_id` varchar(10) DEFAULT NULL,
//  `user_cre_id` varchar(15) DEFAULT NULL,*/
//    public UserVo persistNewUser(UserVo uv, String creatorid) {
//        uv.setId(getNextUserId());
//        Date dd = new Date(System.currentTimeMillis());
//        Timestamp tt = new Timestamp(dd.getTime());
//        String columns = "user_id, user_name, password, first_name, middle_name, last_name, user_loc_id, user_role_id, user_cre_id";
//        String values = "?, ?, ?, ?, ?, ?, ?, ?, ?";
//        PreparedStatement ps = null;
//        try {
//            ps = this.conn.prepareStatement("insert into user_rec(" + columns + ") values(" + values + ")");
//            ps.setString(1, uv.getId());
//            ps.setString(2, uv.getEmail());
//            ps.setString(3, Encryption.encrypt(uv.getPassword()));
//            ps.setString(4, uv.getRoleId());
//            ps.setTimestamp(5, tt);
//            ps.setString(6, uv.getPhoneNumber());
//            ps.setString(7, uv.getLastName());
//            ps.setString(8, uv.getFirstName());
//            ps.setString(9, uv.getAddress());
//            ps.setString(10, uv.getGender());
//            ps.setString(11, "Y");
//            ps.setString(12, uv.getUserName());
//            ps.setString(13, creatorid);
//            ps.setString(14, "Y");
//            ps.execute();
//            Logger.getLogger(UserDao.class.getName()).log(Level.INFO, null, uv);
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
//            return null;
//        } finally{
//        ConnectionManager.cleanUpConnection(conn, ps);
//        }
//        return uv;
//    }
//
//    public List<String> loadUserNames() {
//        PreparedStatement ps = null;
//        List<String> userNames = new ArrayList();
//        try {
//            ps = this.conn.prepareStatement("select*from user_rec");
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                userNames.add(rs.getString("USERNAME"));
//            }
//            Logger.getLogger(UserDao.class.getName()).log(Level.INFO, null, "usernames loaded");
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
//        }finally{
//        ConnectionManager.cleanUpConnection(conn, ps);
//        }
//        return userNames;
//    }
//
//    public boolean changeStatus(UserVo uv) {
//        Logger.getLogger(UserDao.class.getName()).log(Level.INFO, null, " about to decativate user User user details is.............." + uv);
//        PreparedStatement ps = null;
//        try {
//            ps = this.conn.prepareStatement("update user_rec set ACTIVE = ? where USERID = ?");
//            ps.setString(1, uv.getActive());
//            ps.setString(2, uv.getId());
//            ps.execute();
//            Logger.getLogger(UserDao.class.getName()).log(Level.INFO, null, " decativation successful..............");
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
//            return false;
//        }finally{
//        ConnectionManager.cleanUpConnection(conn, ps);
//        }
//        return true;
//    }
//
//    public boolean updateUser(UserVo uv) {
//        Logger.getLogger(UserDao.class.getName()).log(Level.INFO, null, "in dao about to save user User user details is.............." + uv);
//        PreparedStatement ps = null;
//        try {
//            ps = this.conn.prepareStatement("update user_rec set EMAIL = ?,PASSWORD = ?,ROLE_ID = ?,PHONE_NUMBER = ?,LASTNAME = ?,FIRSTNAME = ?,ADDRESS = ?,GENDER = ?, ACTIVE = ? where USERID = ?");
//
//            ps.setString(1, uv.getEmail());
//            ps.setString(2, uv.getPassword());
//            ps.setString(3, uv.getRoleId());
//            ps.setString(4, uv.getPhoneNumber());
//            ps.setString(5, uv.getLastName());
//            ps.setString(6, uv.getFirstName());
//            ps.setString(7, uv.getAddress());
//            ps.setString(8, uv.getGender());
//            ps.setString(9, uv.getActive());
//            ps.setString(10, uv.getId());
//            Logger.getLogger(UserDao.class.getName()).log(Level.INFO, null, " update successful..............");
//            ps.execute();
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
//            return false;
//        }finally{
//        ConnectionManager.cleanUpConnection(conn, ps);
//        }
//        return true;
//    }
//
//    public UserVo validateUser(String userName, String password) {
//        Logger.getLogger(UserDao.class.getName()).log(Level.INFO, null, "in dao about to validate user..............");
//        PreparedStatement ps = null;
//        ResultSet rs = null;
//        UserVo uvo = null;
//        try {
//            ps = this.conn.prepareStatement("select * from user_rec where USERNAME=? and password=?");
//            ps.setString(1, userName);
//            ps.setString(2, password);
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                uvo = new UserVo();
//                uvo.setId(rs.getString("USERID"));
//                uvo.setEmail(rs.getString("EMAIL"));
//                uvo.setPassword(rs.getString("PASSWORD"));
//                uvo.setRoleId(rs.getString("ROLE_ID"));
//                uvo.setPhoneNumber(rs.getString("PHONE_NUMBER"));
//                uvo.setLastName(rs.getString("LASTNAME"));
//                uvo.setFirstName(rs.getString("FIRSTNAME"));
//                uvo.setAddress(rs.getString("ADDRESS"));
//                uvo.setDateCreated(rs.getDate("CREATION_DATE"));
//                uvo.setGender(rs.getString("GENDER"));
//                uvo.setActive(rs.getString("ACTIVE"));
//                uvo.setResetPassword(rs.getString("PASSWORD_RESET"));
//                uvo.setUserName(rs.getString("USERNAME"));
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
//            return null;
//        }finally{
//        ConnectionManager.cleanUp(conn, ps, rs);
//        }
//        return uvo;
//    }
//
//    public List<UserVo> loadAllUser() {
//        PreparedStatement ps = null;
//        List<UserVo> userList = new ArrayList();
//        UserVo uvo = null;
//        try {
//            ps = this.conn.prepareStatement("select*from user_rec");
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                uvo = new UserVo();
//                uvo.setId(rs.getString("USERID"));
//                uvo.setEmail(rs.getString("EMAIL"));
//                uvo.setPassword(rs.getString("PASSWORD"));
//                uvo.setRoleId(rs.getString("ROLE_ID"));
//                uvo.setPhoneNumber(rs.getString("PHONE_NUMBER"));
//                uvo.setLastName(rs.getString("LASTNAME"));
//                uvo.setFirstName(rs.getString("FIRSTNAME"));
//                uvo.setAddress(rs.getString("ADDRESS"));
//                uvo.setDateCreated(rs.getDate("CREATION_DATE"));
//                uvo.setGender(rs.getString("GENDER"));
//                uvo.setActive(rs.getString("ACTIVE"));
//                uvo.setUserName(rs.getString("USERNAME"));
//                if (!uvo.getId().equalsIgnoreCase("admin@admin1")) {
//                    userList.add(uvo);
//                }
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
//        }finally{
//        ConnectionManager.cleanUpConnection(conn, ps);
//        }
//        return userList;
//    }
//
//    public UserVo loadUser(String id) {
//        PreparedStatement ps = null;
//        UserVo uvo = null;
//        try {
//            ps = this.conn.prepareStatement("select*from user_rec where USERID = ?");
//            ps.setString(1, id);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                uvo = new UserVo();
//                uvo.setId(rs.getString("USERID"));
//                uvo.setEmail(rs.getString("EMAIL"));
//                uvo.setPassword(rs.getString("PASSWORD"));
//                uvo.setRoleId(rs.getString("ROLE_ID"));
//                uvo.setPhoneNumber(rs.getString("PHONE_NUMBER"));
//                uvo.setLastName(rs.getString("LASTNAME"));
//                uvo.setFirstName(rs.getString("FIRSTNAME"));
//                uvo.setAddress(rs.getString("ADDRESS"));
//                uvo.setDateCreated(rs.getDate("CREATION_DATE"));
//                uvo.setGender(rs.getString("GENDER"));
//                uvo.setActive(rs.getString("ACTIVE"));
//                uvo.setUserName(rs.getString("USERNAME"));
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
//        }finally{
//        ConnectionManager.cleanUp(conn, ps, null);
//        }
//        return uvo;
//    }
//
//    public void updateUserCount(int m) {
//        int n = m + 1;
//        PreparedStatement ps = null;
//        try {
//            ps = this.conn.prepareStatement("update counter set user_count = ?");
//            ps.setInt(1, n);
//            ps.execute();
//        } catch (SQLException ex) {
//          //  Logger.getLogger(ResidentDao.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }
//
//    public String getNextUserId() {
//        int i = 0;
//        try {
//            PreparedStatement ps = null;
//            ps = this.conn.prepareStatement("select user_count from counter ");
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                i = rs.getInt("user_count");
//            }
//            updateUserCount(i);
//        } catch (SQLException ex) {
//         //   Logger.getLogger(ResidentDao.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return "LASREP-" + i;
//    }
//
//    public static void main(String[] args) {
//        UserDao dou = new UserDao();
//    }
//
//    public UserVo selectUser(String username) {
//        UserVo uv = new UserVo();
//        try {
//            Statement st = this.conn.createStatement();
//            String q = "select * from user_rec where userid='" + username + "'";
//            ResultSet rs = st.executeQuery(q);
//            rs.next();
//            uv.setPassword(Encryption.decrypt(rs.getString("PASSWORD")));
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return uv;
//    }
//
//    public boolean changePassword(String newPassword, String username) {
//        try {
//            Statement st = this.conn.createStatement();
//            String q = "update user_rec set PASSWORD = '" + Encryption.encrypt(newPassword) + "' where userid='" + username + "'";
//            st.execute(q);
//            return true;
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return false;
//    }
//
//    public boolean resetPassword(String newPassword, String userid) {
//        try {
//            PreparedStatement ps = null;
//            ps = this.conn.prepareStatement("update user_rec set PASSWORD = ?, PASSWORD_RESET = ?  where userid=?");
//            ps.setString(1, Encryption.encrypt(newPassword));
//            ps.setString(2, "N");
//            ps.setString(3, userid);
//            ps.execute();
//            return true;
//        } catch (SQLException ex) {
//            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return false;
//    }
//}
