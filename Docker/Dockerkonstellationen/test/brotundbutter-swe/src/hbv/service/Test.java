package hbv.service;

import java.io.*;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;


public class Test {
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
	public long doInsert(String name,String email, String passwort,boolean test,String Uhrzeit, String Datum){
		long result=-1;
		try{
			Connection connection = ds.getConnection();
      if(test==true){
			PreparedStatement ps = connection.prepareStatement(
					"insert into user (name, passwort,email,UID)  values(?,?,?,?)",
					Statement.RETURN_GENERATED_KEYS);
			    ps.setObject(1,name);
          ps.setObject(2,passwort);
          ps.setObject(3,email);
          ps.setObject(4,2);
          ps.executeUpdate();
			    ResultSet mrs=ps.getGeneratedKeys();
			    if(mrs.next()){
				    result=mrs.getLong(1);
			    }
			    ps.close();
      }else{
          PreparedStatement ps = connection.prepareStatement(
					"insert into termin (UID,Datum,Uhrzeit,name)  values(?,?,?,?)",
					Statement.RETURN_GENERATED_KEYS);
          ps.setObject(1,2);
          ps.setObject(2,Datum);
          ps.setObject(3,Uhrzeit);
          ps.setObject(4,name);
          ps.executeUpdate();
			    ResultSet mrs=ps.getGeneratedKeys();
			    if(mrs.next()){
				    result=mrs.getLong(1);
			    }
			    ps.close();

      }
						connection.close();
		} catch(Exception e){
			throw new RuntimeException(e);
		}
		return result;
	}

}
