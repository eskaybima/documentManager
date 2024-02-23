
import com.fasyl.Dao.ConnectionManager;
import com.fasyl.Dao.DataObject;
import com.fasyl.Dao.OracleConnManager;
import com.fasyl.newjobBo.SaveToDb;
import java.sql.Connection;
import java.util.List;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Adebayo
 */
public class TransferTable {
   private SaveToDb sb = new SaveToDb();
    private void doit(){
    DataObject dao = new DataObject();
    Connection sql = ConnectionManager.getConnection();
    List<String[]> data = dao.getList4(sql, "select country_code, state_code, state from state_data");
    Connection ora = OracleConnManager.getConnection();
    for (int i = 0; i<data.size(); i++) {
        String columns = "count_id, state_id, description";
        String values = "'"+data.get(i)[0]+ "', '" +data.get(i)[1]+"', '"+data.get(i)[2]+"'";
        String query = "insert into fas_mst_state(" + columns + ") values(" + values + ")";
        sb.persist(query);
    }
    }     
 public static void main(String[] args){
       TransferTable  tb = new TransferTable();
       tb.doit();
}
}


/*
 create table fas_mst_state (
state_id varchar2(10),
description varchar2(40),
state_cre_user_id varchar2(10),
state_cre_dt date ,
count_id varchar2(5) ,
 
 */