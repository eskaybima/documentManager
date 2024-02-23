package com.fasyl.newjobBo;

import java.util.ArrayList;
import java.util.List;

public class Refinery {

    public static List<String[]> refineValue(String ref_id) {
        List<String[]> output = new ArrayList<>();
        SaveToDb sb = new SaveToDb();
        String template = sb.getValue2("select template from template_id where ref_id ='" + ref_id + "'");
        List<String[]> crude_parameters = sb.getListss("select param_names, type from params_table_" + template + " where type not in ('DOCUMENT')", 2);
        String[] data = null;
        
        for (String[] crude_parameter : crude_parameters) {
            data = new String[2];
            if ("SUBHEAD".equalsIgnoreCase(crude_parameter[1])) {
                data[0] = crude_parameter[0];
                data[1] = crude_parameter[1];
            } else {
                data[0] = crude_parameter[0];
                data[1] = sb.getValue2("select " + crude_parameter[0] + " from " + template + " where ref_id = '" + ref_id + "'");
            }
            output.add(data);
        }
        data = new String[2];
        data[0] = "Uploaded By";
        data[1] = sb.getValue2("select uploaded_by from " + template + " where ref_id ='" + ref_id + "'");
        output.add(data);
        return output;
    }

}
