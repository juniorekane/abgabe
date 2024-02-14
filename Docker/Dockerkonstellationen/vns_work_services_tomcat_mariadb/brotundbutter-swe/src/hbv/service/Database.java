package hbv.service;

import java.io.*;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;


public class Database {
	static DataSource ds;
	public static void init() {
		try{
			Context initCtx = new InitialContext();
			ds = (DataSource)initCtx.lookup("java:/comp/env/jdbc/mariadb");
		}catch(NamingException ne){
			//TODO: dont write TODO in catch
		}
	}
	public void doQuery(PrintWriter out){
		try{
			Connection connection = ds.getConnection();
			PooledConnection pc = (PooledConnection)connection;
			Connection actual = pc.getConnection();
			PreparedStatement pss = connection.prepareStatement(
					"select * from demo where id = ?");
			pss.setInt(1,1);
			ResultSet rs = pss.executeQuery();
			int rows=0;
			while(rs.next()){
				long id = rs.getLong("id");
				String name = rs.getString("name");
				out.format("%3d %20s \n",id,name);
			}
			rs.close();
			pss.close();
			connection.close();
		} catch(Exception e){
			throw new RuntimeException(e);
		}
		long ende = System.currentTimeMillis();
	}
	public long doInsert(String name){
		long result=-1;
		try{
			Connection connection = ds.getConnection();
			PreparedStatement ps = connection.prepareStatement(
					"insert into user (name,passwort,email,UID)  values(?,?,?,?)",
					Statement.RETURN_GENERATED_KEYS);
			ps.setObject(1,name);
      ps.setObject(2,"Beispielpasswort");
      ps.setObject(3,"email");
      ps.setObject(4,"UID");
			ps.executeUpdate();
			ResultSet mrs=ps.getGeneratedKeys();
			if(mrs.next()){
				result=mrs.getLong(1);
			}
			ps.close();
      PreparedStatement qs = connection.prepareStatement(
					"insert into termin (UID,datum,uhrzeit,name)  values(?,?,?,?)",
					Statement.RETURN_GENERATED_KEYS);
			qs.setObject(1,name);
      qs.setObject(2,"Beispieldatum");
      qs.setObject(3,"uhrzeit");
      qs.setObject(4,"UID");
			qs.executeUpdate();
			ResultSet mrs2=qs.getGeneratedKeys();
			if(mrs2.next()){
				result=mrs2.getLong(1);
			}
			qs.close();

			connection.close();
		} catch(Exception e){
			throw new RuntimeException(e);
		}
		return result;
	}

}
