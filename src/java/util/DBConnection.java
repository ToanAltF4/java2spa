/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author khoim
 */
public class DBConnection {
        public static Connection initializeDatabase() throws Exception {
        String jdbcURL = "jdbc:sqlserver://localhost:1433;databaseName=SpaConsultationPortal";
        String jdbcUsername = "sa";
        String jdbcPassword = "12345";

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

}
