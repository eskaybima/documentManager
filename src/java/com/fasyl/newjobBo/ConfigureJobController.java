/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import com.fasyl.vo.AccessControl;
import com.fasyl.vo.DefineWorkFlowVo;
import com.fasyl.vo.ParameterValues;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.io.FileUtils;

@WebServlet(name = "ConfigureJobController", urlPatterns = {"/ConfigureJobController"})
public class ConfigureJobController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SaveToDb sb = new SaveToDb();
        HttpSession session = request.getSession(true);
        List<ParameterValues> parameters = null;
        if (request.getParameter("createList") != null) {
            parameters = new ArrayList<>();
            List<String> defaultValues = new ArrayList<>();
            session.setAttribute("parameters", parameters);
            session.setAttribute("defaultValues", defaultValues);
        }
        if (request.getParameter("control").equalsIgnoreCase("addParameter")) {
            dispatch(request, response, "/pages/configure_job.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("formList")) {
            String listType = request.getParameter("formList");
            List<String> values = new ArrayList<>();

            if ("State".equalsIgnoreCase(listType)) {
                values = sb.getList2("select distinct DESCRIPTION from fas_mst_state order by DESCRIPTION asc");
            } else if ("Countries".equalsIgnoreCase(listType)) {
                values = sb.getList2("select distinct DESCRIPTION from FAS_MST_COUNTRY order by DESCRIPTION asc");
            } else if ("Titles".equalsIgnoreCase(listType)) {
                values = sb.getList2("select distinct title from FAS_MST_TITLES order by title asc");
            }
            session.setAttribute("values", values);
            request.setAttribute("parameter_to_edit", request.getParameter("parameter_to_edit"));
            dispatch(request, response, "/pages/edit_parameter.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("deleteParameter")) {
            String parameter = request.getParameter("parameter");
            parameters = new ArrayList<>();
            List<ParameterValues> presentParams = (List<ParameterValues>) session.getAttribute("parameters");
            for (int i = 0; i < presentParams.size(); i++) {
                if (!parameter.equalsIgnoreCase(presentParams.get(i).getParameterName())) {
                    parameters.add(presentParams.get(i));
                }
                session.setAttribute("parameters", parameters);
            }
            dispatch(request, response, "/pages/configure_job.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("deleteValue")) {
            String value = request.getParameter("value");
            List<String> values = new ArrayList<>();
            List<String> presentValues = (List<String>) session.getAttribute("values");
            for (int i = 0; i < presentValues.size(); i++) {
                if (!value.equalsIgnoreCase(presentValues.get(i))) {
                    values.add(presentValues.get(i));
                }
                session.setAttribute("values", values);
            }
            request.setAttribute("parameter_to_edit", request.getParameter("parameter_to_edit"));
            dispatch(request, response, "/pages/edit_parameter.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("submit_values")) {
            List<String> values = (List<String>) session.getAttribute("values");
            String templateName = (String) session.getAttribute("template");
            for (int i = 0; i < values.size(); i++) {
                String query = "insert into param_values_" + templateName + "(parameter_name, param_value) values('" + request.getParameter("parameter_to_edit") + "', '" + values.get(i) + "')";
                sb.persist(query);
            }
            List<String[]> params = sb.getListss("select param_names, type from params_table_" + templateName + "", 2);
            session.setAttribute("params", params);
            List<ParameterValues> newparams = new ArrayList<>();
            session.setAttribute("parameters", newparams);
            session.setAttribute("template", templateName);
            dispatch(request, response, "/pages/loadDropDownValues.jsp");
            //dispatch(request, response, "/pages/homepage.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("exit")) {
            dispatch(request, response, "/pages/homepage.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("deleteValueFromDb")) {
            String query = "delete from  param_values_" + (String) session.getAttribute("template") + " where parameter_name = '" + request.getParameter("parameter_to_edit") + "' and param_value = '" + request.getParameter("value") + "'";
            sb.persist(query);
            request.setAttribute("parameter_to_edit", request.getParameter("parameter_to_edit"));
            dispatch(request, response, "/pages/edit_parameter.jsp");
        }
        // k

        if (request.getParameter("control").equalsIgnoreCase("deleteParameterFromSessionOnEditJob")) {
            List<ParameterValues> newparams = (List<ParameterValues>) session.getAttribute("parameters");
            List<ParameterValues> output = new ArrayList<>();
            for (int i = 0; i < newparams.size(); i++) {
                if (!request.getParameter("parameter_to_edit").equalsIgnoreCase(newparams.get(i).getParameterName())) {
                    output.add(newparams.get(i));
                }
                session.setAttribute("parameters", output);
            }
            dispatch(request, response, "/pages/edit_job.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("editJob")) {
            String template = request.getParameter("template");
            //String tableName = sb.getValue2("select template_name from template_names where description ='" + template + "'");
            String count = sb.getValue2("select count(*) from " + template);
            if ("0".equalsIgnoreCase(count)) {
            List<String[]> params = sb.getListss("select param_names, type from params_table_" + request.getParameter("template") + "", 2);
            session.setAttribute("params", params);
            List<ParameterValues> newparams = new ArrayList<>();
            session.setAttribute("parameters", newparams);
            session.setAttribute("template", template);
            dispatch(request, response, "/pages/edit_job.jsp");
            } else {
            request.setAttribute("message", template + " already has data inputted and can not be modified. Please create another version. Thanks");
            request.setAttribute("status", "error");
            dispatch(request, response, "/pages/homepage.jsp");
            }
        }

        if (request.getParameter("control").equalsIgnoreCase("submitEditJob")) {

            String template = ((String) session.getAttribute("template")).replace(" ", "_");
            List<ParameterValues> newparams = (List<ParameterValues>) session.getAttribute("parameters");
            for (int i = 0; i < newparams.size(); i++) {
                String query = "insert into params_table_" + template + "(param_names, type) values('" + newparams.get(i).getParameterName().replace(" ", "_").toLowerCase() + "','" + newparams.get(i).getDatatype() + "')";
                sb.persist(query);
            }

            for (int i = 0; i < newparams.size(); i++) {
                System.out.println(" the incomming datatype is " + newparams.get(i).getDatatype());
                if (!"document".equalsIgnoreCase(newparams.get(i).getDatatype())) {
                    String query = "alter table " + template + " add " + newparams.get(i).getParameterName().replace(" ", "_").toLowerCase() + " varchar(100)";
                    sb.persist(query); //parameters.get(i).getParameterName().replace(" ", "_").toLowerCase()
                }
            }
            List<String[]> vals = sb.getListss("select param_names, type from params_table_" + template + "", 2);
            newparams = new ArrayList<>();
            for (int i = 0; i < vals.size(); i++) {
                ParameterValues pv = new ParameterValues();
                pv.setParameterName(vals.get(i)[0]);
                pv.setDatatype(vals.get(i)[1]);
                newparams.add(pv);
            }
            recreateUploadPage(newparams, request, response, template);
            dispatch(request, response, "/pages/homepage.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("deleteParameterFromDb")) {
            String query = "delete from  params_table_" + request.getParameter("template").replace(" ", "_") + " where param_names = '" + request.getParameter("parameter_to_edit") + "'";
            sb.persist(query);

            List<String[]> params = new SaveToDb().getListss("select param_names, type from params_table_" + request.getParameter("template").replace(" ", "_") + "", 2);
            session.setAttribute("params", params);
            dispatch(request, response, "/pages/edit_job.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("delete_param")) {
            String query = "delete from  params_table_" + request.getParameter("template").replace(" ", "_") + " where param_names = '" + request.getParameter("parameter") + "'";
            sb.persist(query);
            List<String[]> params = new SaveToDb().getListss("select param_names, type from params_table_" + request.getParameter("template").replace(" ", "_") + "", 2);
            session.setAttribute("params", params);
            request.setAttribute("showSubmit", "yes");
            dispatch(request, response, "/pages/edit_job.jsp");

        }

        if (request.getParameter("control").equalsIgnoreCase("addParameterFromEdit")) {
            dispatch(request, response, "/pages/edit_job.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("edit_parameter")) {
            //String parameter = request.getParameter("parameter");
            List<String> values = new ArrayList<>();
            session.setAttribute("values", values);
            request.setAttribute("parameter_to_edit", request.getParameter("parameter"));
            dispatch(request, response, "/pages/edit_parameter.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("addValue")) {
            request.setAttribute("parameter_to_edit", request.getParameter("parameter_to_edit"));
            dispatch(request, response, "/pages/edit_parameter.jsp");
        }
 
        if (request.getParameter("control").equalsIgnoreCase("createUserGroup")) {
            List<String> curr_members = new ArrayList<>();
            String groupName = "";
            session.setAttribute("taskType", "Create");
            session.setAttribute("groupName", groupName);
            session.setAttribute("curr_members", curr_members);
            dispatch(request, response, "/pages/createUserGroup.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("modifyUserGroup")) {
            String groupName = request.getParameter("userGroup");
            session.setAttribute("groupName", groupName);
            session.setAttribute("taskType", "Modify");
            List<String> curr_members = sb.getList2("select distinct user_member from user_group where group_name = '" + groupName + "'");
            session.setAttribute("curr_members", curr_members);
            dispatch(request, response, "/pages/createUserGroup.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("add_group_member")) {
            String groupName = (String) session.getAttribute("groupName");
            System.out.println("jjj " + request.getParameter("taskType"));
            if (!"modify".equalsIgnoreCase(request.getParameter("taskType"))) {
            if (sb.isAvailable("select group_name from user_group where group_name = '" + groupName + "'")) {
                request.setAttribute("message", groupName + " already choosen. Please use another name");
                request.setAttribute("status", "error");
            }
            }
            dispatch(request, response, "/pages/createUserGroup.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("delete_group_member")) {
            List<String> input = (List<String>) session.getAttribute("curr_members");
            List<String> output = new ArrayList<>();
            for (int i = 0; i < input.size(); i++) {
                if (!request.getParameter("member_for_delete").equalsIgnoreCase(input.get(i))) {
                    output.add(input.get(i));
                }
                session.setAttribute("curr_members", output);
            }
            dispatch(request, response, "/pages/createUserGroup.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("submitCreateUserGroup")) {
            List<String> input = (List<String>) session.getAttribute("curr_members");
            String groupName = (String) session.getAttribute("groupName");
            String query = "";
            for (int i = 0; i < input.size(); i++) {
                query = "insert into user_group(group_name, user_member) values('" + groupName + "', '" + input.get(i) + "')";
                sb.persist(query);
            }
            request.setAttribute("message", groupName + " successfully created");
            request.setAttribute("status", "success");
            dispatch(request, response, "/pages/homepage.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("editUserGroup")) {
            List<String> input = (List<String>) session.getAttribute("curr_members");
            String groupName = (String) session.getAttribute("groupName");
            String query = "";
            String message = "";
            String status = "";
            query = "delete from user_group where group_name ='" + groupName + "'";
            String result = sb.persist(query);
            if ("success".equalsIgnoreCase(result)) {
                for (int i = 0; i < input.size(); i++) {
                    query = "insert into user_group(group_name, user_member) values('" + groupName + "', '" + input.get(i) + "')";
                    sb.persist(query);
                    message = groupName + " successfully modified";
                    status = "success";
                }
            } else {
                message = "Error modifying user group " +groupName + ". Please try again later";
                status = "success";
            }

            request.setAttribute("message", message);
            request.setAttribute("status", status);
            dispatch(request, response, "/pages/homepage.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("editPaymentType")) {
            dispatch(request, response, "/pages/edit_payment_types.jsp");
        } //
        if (request.getParameter("control").equalsIgnoreCase("delete_pay_type")) {
            String query = "delete from tax_type where tax_name = '" + request.getParameter("tax_name") + "' and description ='" + request.getParameter("description") + "'";
            sb.persist(query);
            dispatch(request, response, "/pages/edit_payment_types.jsp");
        }
        if (request.getParameter("control").equalsIgnoreCase("add_pay_type")) {
            String query = "insert into tax_type(tax_name, description) values('" + request.getParameter("tax_name") + "','" + request.getParameter("description") + "')";
            sb.persist(query);
            dispatch(request, response, "/pages/edit_payment_types.jsp");
        }

        if (request.getParameter("control").equalsIgnoreCase("share_doc")) {
            String result = sb.persist("insert into fas_doc_share(doc_id, shared_by, shared_with) values('" + request.getParameter("id") + "', '" + (String) session.getAttribute("username") + "', '" + request.getParameter("user") + "')");

            if ("success".equalsIgnoreCase(result)) {
                request.setAttribute("message", "Document successfully shared with " + request.getParameter("user"));
                request.setAttribute("status", "success");
            } else {
                request.setAttribute("message", "Action failed. Please contact admin");
                request.setAttribute("status", "error");
            }
            dispatch(request, response, "/pages/homepage.jsp");
        }
    }

    boolean createPage(HttpServletRequest request, HttpServletResponse response, List<ParameterValues> parameters) throws ServletException, IOException {
        boolean isDropDown = false;
        String templateName = "";
        HttpSession session = request.getSession(true);
        SaveToDb sb = new SaveToDb();
        templateName = (String) session.getAttribute("templateName");
        String formHeader = (String) session.getAttribute("formHeader");
        String code = "<%@page import=\"com.fasyl.newjobBo.PageUtil\"%>";
        code = code + "\n<%@page import=\"com.fasyl.newjobBo.SaveToDb\"%>";
        code = code + "\n<%@page import=\"java.util.ArrayList\"%>";
        code = code + "\n<%@page import=\"java.util.List\"%>";
        code = code + "\n<%@page contentType=\"text/html\" pageEncoding=\"UTF-8\"%>";
        code = code + "\n<html>\n<head>";
        code = code + "\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8 />";
        code = code + "\n<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\" />";
        code = code + "\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />";
        code = code + "\n<title>Upload New Job</title>";
        code = code + "\n<jsp:include page=\"pagesimport.jsp\"></jsp:include>";
        code = code + "\n<script language=\"JavaScript\" src=\"resources/javaScript/checkuploadsize.js\"></script>";
        code = code + "\n<script language=\"JavaScript\" src=\"resources/javaScript/notapJs.js\"></script>";
        code = code + "\n<script language=\"JavaScript\" src=\"resources/javaScript/extFile.js\"></script>";
        code = code + "\n<link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/fordialog.css\" />";
        code = code + "\n<link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/dropzone.css\" />";
        code = code + "\n<link href=\"resources/css/dropzone.css\" type=\"text/css\" rel=\"stylesheet\" />";
        code = code + "\n</head>";
        code = code + "\n<body id=\"background\">";
        code = code + "\n<div class=\"page-container\">";
        code = code + "\n<jsp:include page=\"leftMenu.jsp\"></jsp:include>";
        code = code + "\n<div class=\"page-content\">";
        code = code + "\n<jsp:include page=\"header.jsp\"></jsp:include>";
        code = code + "\n<ul class=\"breadcrumb\">";
        code = code + "\n<li><a href=\"${pageContext.request.contextPath}/pages/homepage.jsp\">Home</a></li>";
        code = code + "\n<li><a href=\"#\">Upload Operations</a></li>";
        code = code + "\n<li class=\"active\">Scan New Jobs</li>";
        code = code + "\n</ul>";
        code = code + "\n<div id=\"bodyhold\">";
        code = code + "\n<div id=\"bodycon\">";
        code = code + "\n<div id='ajaxDiv'></div>";
        code = code + "\n<div id=\"dialogoverlay\"></div>";
        code = code + "\n<div id=\"dialogbox\">";
        code = code + "\n<div>";
        code = code + "\n<div id=\"dialogboxhead\"></div>";
        code = code + "\n<div id=\"dialogboxbody\"></div>";
        code = code + "\n<div id=\"dialogboxfoot\"></div>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n<%!";
        for (int i = 0; i < parameters.size(); i++) {
            if (!"document".equalsIgnoreCase(parameters.get(i).getDatatype())) {
                code = code + "\nString " + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "= \"\";";
                code = code + "\nList<String> " + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "list;";
            }
        }
        code = code + "\nString ref_id;";
        code = code + "\nList<String> imageList;";
        code = code + "\nList<String> stateList;";
        code = code + "\nList<String> countryList;";
        code = code + "\nSaveToDb sb = new SaveToDb();";
        code = code + "\nString template = \"" + templateName.replace(" ", "_") + "\";";
        code = code + "\nboolean isdocAvailable;";
        code = code + "\n%>";
        code = code + "\n<%";
        for (int i = 0; i < parameters.size(); i++) {
            if ("DROP_DOWN".equalsIgnoreCase(parameters.get(i).getDatatype())) {
                code = code + "\n" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "list = sb.getList2(\"select distinct param_value from param_values_" + templateName.replace(" ", "_") + " where parameter_name ='" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "' order by param_value asc \");";
            }
        }
        code = code + "\nref_id = (String) session.getAttribute(\"applicationId\");";
        code = code + "\nstateList = (List<String>) session.getAttribute(\"stateList\");";
        code = code + "\nimageList = (List<String>) session.getAttribute(\"imageList\");";
        code = code + "\ncountryList = (List<String>) session.getAttribute(\"countryList\");";
        code = code + "\n if (imageList == null){ imageList = new ArrayList<String>();}";
        code = code + "\nif ((String) request.getAttribute(\"offset\") != null) {";
        for (int i = 0; i < parameters.size(); i++) {
            if (!"document".equalsIgnoreCase(parameters.get(i).getDatatype())) {
                code = code + "\n" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "= (String) request.getAttribute(\"" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "\");";
            }
        }
        code = code + "\n}";
        code = code + "\n%>";
        code = code + "\n<div class=\"page-content-wrap\">";
        code = code + "\n<div class=\"row\">";
        code = code + "\n<div class=\"col-md-offset-1 col-md-10\">";
        code = code + "\n<div class=\"panel panel-primary\">";
        code = code + "\n<div class=\"panel-body\">";
        code = code + "<div class=\"modal-header\">";
        code = code + "<h3>" + formHeader + "</h3>";
        code = code + "<div class=\"clear\"></div>";
        code = code + "</div>";
        code = code + "\n<form class=\"form-horizontal\">";
        code = code + "\n<div class=\"form-group\">";
        code = code + "\n<label class=\"col-md-3 col-xs-12 control-label\">Reference ID:</label>";
        code = code + "\n<div class=\"col-md-6 col-xs-12\">";
        code = code + "\n<div class=\"input-group\">";
        code = code + "\n<label class=\"control-label\">";
        code = code + "<strong><%= ref_id%></strong>";
        code = code + "\n</label>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        for (int i = 0; i < parameters.size(); i++) {
            if (!parameters.get(i).getDatatype().equalsIgnoreCase("DOCUMENT")) {
                if (parameters.get(i).getDatatype().equalsIgnoreCase("SUBHEAD")) {
                    code = code + "\n<div class=\"modal-header\"><span class=\"h5 text-info\"> " + parameters.get(i).getParameterName() + "</strong></span></div><br>";
                } else {
                    code = code + "\n<div class=\"form-group\">";
                    code = code + "\n<label class=\"col-md-3 col-xs-12 control-label\">" + parameters.get(i).getParameterName().replace("_", " ").toUpperCase() + ":</label>";
                    code = code + "\n<div class=\"col-md-6 col-xs-12\">";
                    if (!(parameters.get(i).getDatatype().equalsIgnoreCase("DROP_DOWN"))) {;

                        if ((parameters.get(i).getDatatype().equalsIgnoreCase("STRING"))) {
                            code = code + "\n<input type=\"text\" class=\"form-control\" placeholder=\" " + parameters.get(i).getParameterName() + "\" name=\"" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "\" value=\"<%=" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "%>\" id=\"" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "\"  onchange=\"renderElseWhere('" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "', 'loghc')\"/>";
                        } else if ((parameters.get(i).getDatatype().equalsIgnoreCase("DATE"))) {
                            code = code + "\n<input type=\"text\" class=\"form-control datepicker\" placeholder=\" " + parameters.get(i).getParameterName() + "\" name=\"" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "\" value=\"<%=" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "%>\" id=\"" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "\"  onchange=\"renderElseWhere('" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "', 'loghc')\"/>";
                        }
                    } else {
                        code = code + "\n<select name=\"" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "\" value=\"<%=" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "%>\"   class=\"form-control select\"  id=\"" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "\" onchange=\"renderElseWhere('" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "', 'loghc')\" />";
                        code = code + "\n<option value=\"<%=" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "%>\"><%=" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "%></option>";
                        code = code + "\n<% for (int i = 0; i < " + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "list.size(); i++) {%>";
                        code = code + "\n<option value=\"<%=" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "list.get(i)%>\"><%=" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "list.get(i)%></option>";
                        code = code + "\n<%}%>";
                        code = code + "\n</select>";
                    }
                    code = code + "\n</div>";
                    code = code + "\n</div>";
                }
            }
        }
        code = code + "\n<div class=\"form-group\">";
        code = code + "\n<label class=\"col-md-3 col-xs-12 control-label\">SELECT DOCUMENT:</label>";
        code = code + "\n<div class=\"col-md-6 col-xs-12\">";
        code = code + "\n <select type=\"text\" class=\"form-control\" name=\"jobType\" value=\"\" id=\"jobType\" onchange=\"renderElseWhere6('jobType', 'loghc')\" />";
        code = code + "\n</select>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n<table class=\"table table-striped table-bordered table-hover\" id=\"applDocuments\">";
        code = code + "\n<thead>";
        code = code + "\n<tr>";
        code = code + "\n<th width=\"30%\"><span class=\"fa fa-file\"></span> Document Type</th>";
        code = code + "\n<th width=\"40%\"><span class=\"fa fa-eye\"></span> View</th>";
        code = code + "\n<th width=\"30%\"><span class=\"fa fa-trash-o\"></span> Delete</th>";
        code = code + "\n</tr>";
        code = code + "\n</thead>";
        code = code + "\n</table>";
        code = code + "\n<div class=\"well well-sm\" id=\"fileUploadDiv\">";
        code = code + "\n<div class=\"text-primary h5\"><span class=\"fa fa-cloud-upload\"></span> File Upload</div>";
        code = code + "\n<div class=\"form-group\">";
        code = code + "\n<label class=\"col-md-3 col-xs-12 control-label\">File Section:</label>";
        code = code + "\n<div class=\"col-md-3 col-xs-12\" id=\"select-controller\">";
        code = code + "\n<input type=\"file\" class=\"fileinput btn-default\" name=\"file0\" id=\"file-select\"   title=\"Choose File From Disk\"/>";
        code = code + "\n</div>";
        code = code + "\n<div class=\"col-md-3 col-xs-12\">";
        code = code + "\n<button  class=\"btn btn-success\" id=\"upload-button\"><span class=\"fa fa-upload\"></span> Upload</button>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n</form>";
        code = code + "\n<div class=\"row\">";
        code = code + "\n<div class=\"col-md-15\">";
        code = code + "\n<div class=\"panel panel-default\">";
        code = code + "\n<div class=\"panel-body panel-body-table\">";
        code = code + "\n<div class=\"table-responsive\">";
        code = code + "\n";
        code = code + "\n<form action =\"${pageContext.request.contextPath}/ImageUpload\" method=\"post\">";
        code = code + "\n<table class=\"table\">";
        code = code + "\n<td>";
        code = code + "\n<input type =\"hidden\" name =\"template\"  value =\"<%=template%>\">";
        code = code + "\n<input type =\"hidden\" name =\"done\"  value =\"yes\">";
        code = code + "\n</td>";
        code = code + "\n<td></td>";
        code = code + "\n<td></td>";
        code = code + "\n<td></td>";
        code = code + "\n<td></td>";
        code = code + "\n<td></td>";
        code = code + "\n";
        code = code + "\n<td>";
        code = code + "\n<div class=\"col-md-3 col-xs-12\">";
        code = code + "\n<Button class=\"btn btn-success\" type=\"submit\"><span class=\"fa fa-send-o\"></span> Submit</Button>";
        code = code + "\n</div>";
        code = code + "\n</td>";
        code = code + "\n</table>";
        code = code + "\n</form>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n<p id=\"loghc\" style=\"height: 10px; display: none;\"> </p>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n<script>";
        code = code + "\nfunction renderElseWhere(id, loc) {";
        code = code + "\nvar paramValue = document.getElementById(id).value;";
        code = code + "\nvar print = '<img src=\"${pageContext.request.contextPath}/Initiator?paramValue=' + paramValue + '&paramName='+id+'&control=one\";\">';";
        code = code + "\ndocument.getElementById(loc).innerHTML = print";
        code = code + "\n}";
        code = code + "\n</script>";
        code = code + "\n<script>";
        code = code + "\nfunction renderElseWhere6(id, loc) {";
        code = code + "\nvar jobType = document.getElementById(id).value;";
        code = code + "\nvar print = '<img src=\"${pageContext.request.contextPath}/Initiator?jobType=' + jobType + '&imagecontrol=imageselect\";\">';";
        code = code + "\ndocument.getElementById(loc).innerHTML = print";
        code = code + "\n}";
        code = code + "\n</script>";
        code = code + "</div></div></div>";
        try {
            //String path = "C:/DocumentManager/web/pages/";
			String path = "C:/Users/Adebayo/Documents/NetBeansProjects/DocumentManager/web/pages/";
            path = path + templateName.replace(" ", "_") + ".jsp";
            File destinationJsp = new File(path);
            destinationJsp.createNewFile();
            FileUtils.writeStringToFile(destinationJsp, code);
        } catch (IOException ex) {
            Logger.getLogger(ConfigureJobController.class.getName()).log(Level.SEVERE, null, ex);
        }
        String dropTable = "drop table " + templateName.replace(" ", "_");
        String dropTableResult = new SaveToDb().persist(dropTable);
        String createTableQuerry = "create table " + templateName.replace(" ", "_") + "(";
        createTableQuerry = createTableQuerry + "\nref_id varchar2(100),";
        for (int i = 0; i < parameters.size(); i++) {
            if ("String".equalsIgnoreCase(parameters.get(i).getDatatype()) | "DROP_DOWN".equalsIgnoreCase(parameters.get(i).getDatatype()) | "DATE".equalsIgnoreCase(parameters.get(i).getDatatype())) {
                createTableQuerry = createTableQuerry + "\n" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + " varchar2(100),";
            } else if (parameters.get(i).getDatatype().equalsIgnoreCase("Number")) {
                createTableQuerry = createTableQuerry + "\n" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + " Number(17,2),";
            }
//            else if (parameters.get(i).getDatatype().equalsIgnoreCase("Date")) {
//                createTableQuerry = createTableQuerry + "\n" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + " Date,";
//            }
        }
        createTableQuerry = createTableQuerry + "\nstatus varchar2(100),";
        createTableQuerry = createTableQuerry + "\nuploaded_by varchar2(100),";
        createTableQuerry = createTableQuerry + "\napproved_by varchar2(100),";  //approved_status
        createTableQuerry = createTableQuerry + "\napproved_status varchar2(100),";
        createTableQuerry = createTableQuerry + "\nUploadDate timestamp default systimestamp,";
        //second timestamp default systimestamp
        createTableQuerry = createTableQuerry + "\ndirector_assigned varchar2(100),";
        createTableQuerry = createTableQuerry + "\nuser_assigned varchar2(100),";
        createTableQuerry = createTableQuerry + "\nuser_init varchar2(100),";
        createTableQuerry = createTableQuerry + "\ncontrol varchar2(100),";
        createTableQuerry = createTableQuerry + "\nprocessed varchar2(100),";
        createTableQuerry = createTableQuerry + "\naccess_control varchar2(20),";
        createTableQuerry = createTableQuerry + "\nCONSTRAINT " + templateName.replace(" ", "_") + "_pk PRIMARY KEY (ref_id)";
        createTableQuerry = createTableQuerry + "\n )";
        String createTableResult = new SaveToDb().persist(createTableQuerry);
        dropTable = "drop table params_table_" + templateName.replace(" ", "_");
        dropTableResult = sb.persist(dropTable);
        createTableQuerry = "create table params_table_" + templateName.replace(" ", "_") + "(";
        createTableQuerry = createTableQuerry + "\nparam_names varchar2(100),";
        createTableQuerry = createTableQuerry + "\ntype varchar2(100)";
        createTableQuerry = createTableQuerry + "\n )";
        createTableResult = sb.persist(createTableQuerry);
        createTableQuerry = "create table param_values_" + templateName.replace(" ", "_") + "(";
        createTableQuerry = createTableQuerry + "\nparameter_name varchar2(100),";
        createTableQuerry = createTableQuerry + "\nparam_value varchar2(100)";
        createTableQuerry = createTableQuerry + "\n )";
        createTableResult = sb.persist(createTableQuerry);
        for (int i = 0; i < parameters.size(); i++) {
            String insertQuery = "insert into params_table_" + templateName.replace(" ", "_") + "(param_names, type) values('" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "', '" + parameters.get(i).getDatatype() + "')";
            sb.persist(insertQuery);
            if ("DROP_DOWN".equalsIgnoreCase(parameters.get(i).getDatatype())) {
                isDropDown = true;
            }
        }
        templateName = templateName.replace(" ", "_");
        String insertQuery = "insert into template_names(template_name, description, version_no) values('" + templateName + "', '" + (String) session.getAttribute("description") + "', 1)";
        sb.persist(insertQuery);
        if (isDropDown) {
            List<String[]> params = sb.getListss("select param_names, type from params_table_" + templateName + "", 2);
            session.setAttribute("params", params);
            List<ParameterValues> newparams = new ArrayList<>();
            session.setAttribute("parameters", newparams);
            session.setAttribute("template", templateName);
        }
        return isDropDown;
    }

    private void recreateUploadPage(List<ParameterValues> parameters, HttpServletRequest request, HttpServletResponse response, String templateName) throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        SaveToDb sb = new SaveToDb();
        boolean isDropDown = false;
        System.out.println("hhhhhhhhhhhhhhhhhhhhhhh " + templateName);
        String formHeader = templateName.replace("_", " ");
        String code = "<%@page import=\"com.fasyl.newjobBo.PageUtil\"%>";
        code = code + "\n<%@page import=\"com.fasyl.newjobBo.SaveToDb\"%>";
        code = code + "\n<%@page import=\"java.util.ArrayList\"%>";
        code = code + "\n<%@page import=\"java.util.List\"%>";
        code = code + "\n<%@page contentType=\"text/html\" pageEncoding=\"UTF-8\"%>";
        code = code + "\n<html>\n<head>";
        code = code + "\n<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8 />";
        code = code + "\n<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\" />";
        code = code + "\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />";
        code = code + "\n<title>Upload New Job</title>";
        code = code + "\n<jsp:include page=\"pagesimport.jsp\"></jsp:include>";
        code = code + "\n<script language=\"JavaScript\" src=\"resources/javaScript/checkuploadsize.js\"></script>";
        code = code + "\n<script language=\"JavaScript\" src=\"resources/javaScript/notapJs.js\"></script>";
        code = code + "\n<script language=\"JavaScript\" src=\"resources/javaScript/extFile.js\"></script>";
        code = code + "\n<link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/fordialog.css\" />";
        code = code + "\n<link rel=\"stylesheet\" type=\"text/css\" href=\"resources/css/dropzone.css\" />";
        code = code + "\n<link href=\"resources/css/dropzone.css\" type=\"text/css\" rel=\"stylesheet\" />";
        code = code + "\n</head>";
        code = code + "\n<body id=\"background\">";
        code = code + "\n<div class=\"page-container\">";
        code = code + "\n<jsp:include page=\"leftMenu.jsp\"></jsp:include>";
        code = code + "\n<div class=\"page-content\">";
        code = code + "\n<jsp:include page=\"header.jsp\"></jsp:include>";
        code = code + "\n<ul class=\"breadcrumb\">";
        code = code + "\n<li><a href=\"${pageContext.request.contextPath}/pages/homepage.jsp\">Home</a></li>";
        code = code + "\n<li><a href=\"#\">Upload Operations</a></li>";
        code = code + "\n<li class=\"active\">Scan New Jobs</li>";
        code = code + "\n</ul>";
        code = code + "\n<div id=\"bodyhold\">";
        code = code + "\n<div id=\"bodycon\">";
        code = code + "\n<div id='ajaxDiv'></div>";
        code = code + "\n<div id=\"dialogoverlay\"></div>";
        code = code + "\n<div id=\"dialogbox\">";
        code = code + "\n<div>";
        code = code + "\n<div id=\"dialogboxhead\"></div>";
        code = code + "\n<div id=\"dialogboxbody\"></div>";
        code = code + "\n<div id=\"dialogboxfoot\"></div>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n<%!";
        for (int i = 0; i < parameters.size(); i++) {
            if (!"document".equalsIgnoreCase(parameters.get(i).getDatatype())) {
                code = code + "\nString " + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "= \"\";";
                code = code + "\nList<String> " + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "list;";
            }
        }
        code = code + "\nString ref_id;";
        code = code + "\nList<String> imageList;";
        code = code + "\nList<String> stateList;";
        code = code + "\nList<String> countryList;";
        code = code + "\nSaveToDb sb = new SaveToDb();";
        code = code + "\nString template = \"" + templateName.replace(" ", "_") + "\";";
        code = code + "\nboolean isdocAvailable;";
        code = code + "\n%>";
        code = code + "\n<%";
        for (int i = 0; i < parameters.size(); i++) {
            if ("DROP_DOWN".equalsIgnoreCase(parameters.get(i).getDatatype())) {
                code = code + "\n" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "list = sb.getList2(\"select distinct param_value from param_values_" + templateName.replace(" ", "_") + " where parameter_name ='" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "' order by param_value asc \");";
            }
        }
        code = code + "\nref_id = (String) session.getAttribute(\"applicationId\");";
        code = code + "\nstateList = (List<String>) session.getAttribute(\"stateList\");";
        code = code + "\nimageList = (List<String>) session.getAttribute(\"imageList\");";
        code = code + "\ncountryList = (List<String>) session.getAttribute(\"countryList\");";
        code = code + "\n if (imageList == null){ imageList = new ArrayList<String>();}";
        code = code + "\nif ((String) request.getAttribute(\"offset\") != null) {";
        for (int i = 0; i < parameters.size(); i++) {
            if (!"document".equalsIgnoreCase(parameters.get(i).getDatatype())) {
                code = code + "\n" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "= (String) request.getAttribute(\"" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "\");";
            }
        }
        code = code + "\n}";
        code = code + "\n%>";
        code = code + "\n<div class=\"page-content-wrap\">";
        code = code + "\n<div class=\"row\">";
        code = code + "\n<div class=\"col-md-offset-1 col-md-10\">";
        code = code + "\n<div class=\"panel panel-primary\">";
        code = code + "\n<div class=\"panel-body\">";
        code = code + "<div class=\"modal-header\">";
        code = code + "<h3>" + formHeader + "</h3>";
        code = code + "<div class=\"clear\"></div>";
        code = code + "</div>";
        code = code + "\n<form class=\"form-horizontal\">";
        code = code + "\n<div class=\"form-group\">";
        code = code + "\n<label class=\"col-md-3 col-xs-12 control-label\">Reference ID:</label>";
        code = code + "\n<div class=\"col-md-6 col-xs-12\">";
        code = code + "\n<div class=\"input-group\">";
        code = code + "\n<label class=\"control-label\">";
        code = code + "<strong><%= ref_id%></strong>";
        code = code + "\n</label>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n</div>";

        for (int i = 0; i < parameters.size(); i++) {
            if (!parameters.get(i).getDatatype().equalsIgnoreCase("DOCUMENT")) {
                if (parameters.get(i).getDatatype().equalsIgnoreCase("SUBHEAD")) {
                    code = code + "\n<div class=\"modal-header\"><span class=\"h5 text-info\"> " + parameters.get(i).getParameterName() + "</strong></span></div><br>";
                } else {
                    code = code + "\n<div class=\"form-group\">";
                    code = code + "\n<label class=\"col-md-3 col-xs-12 control-label\">" + parameters.get(i).getParameterName().replace("_", " ").toUpperCase() + ":</label>";
                    code = code + "\n<div class=\"col-md-6 col-xs-12\">";
                    if (!(parameters.get(i).getDatatype().equalsIgnoreCase("DROP_DOWN"))) {;

                        if ((parameters.get(i).getDatatype().equalsIgnoreCase("STRING"))) {
                            code = code + "\n<input type=\"text\" class=\"form-control\" placeholder=\" " + parameters.get(i).getParameterName() + "\" name=\"" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "\" value=\"<%=" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "%>\" id=\"" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "\"  onchange=\"renderElseWhere('" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "', 'loghc')\"/>";
                        } else if ((parameters.get(i).getDatatype().equalsIgnoreCase("DATE"))) {
                            code = code + "\n<input type=\"text\" class=\"form-control datepicker\" placeholder=\" " + parameters.get(i).getParameterName() + "\" name=\"" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "\" value=\"<%=" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "%>\" id=\"" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "\"  onchange=\"renderElseWhere('" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "', 'loghc')\"/>";
                        }

                    } else {
                        code = code + "\n<select name=\"" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "\" value=\"<%=" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "%>\"   class=\"form-control select\"  id=\"" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "\" onchange=\"renderElseWhere('" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "', 'loghc')\" />";
                        code = code + "\n<option value=\"<%=" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "%>\"><%=" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "%></option>";
                        code = code + "\n<% for (int i = 0; i < " + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "list.size(); i++) {%>";
                        code = code + "\n<option value=\"<%=" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "list.get(i)%>\"><%=" + parameters.get(i).getParameterName().replace(" ", "_").toLowerCase() + "list.get(i)%></option>";
                        code = code + "\n<%}%>";
                        code = code + "\n</select>";
                    }
                    code = code + "\n</div>";
                    code = code + "\n</div>";
                }
            }
        }
        code = code + "\n<div class=\"form-group\">";
        code = code + "\n<label class=\"col-md-3 col-xs-12 control-label\">SELECT DOCUMENT:</label>";
        code = code + "\n<div class=\"col-md-6 col-xs-12\">";
        code = code + "\n <select type=\"text\" class=\"form-control\" name=\"jobType\" value=\"\" id=\"jobType\" onchange=\"renderElseWhere6('jobType', 'loghc')\" />";
        code = code + "\n</select>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n<table class=\"table table-striped table-bordered table-hover\" id=\"applDocuments\">";
        code = code + "\n<thead>";
        code = code + "\n<tr>";
        code = code + "\n<th width=\"30%\"><span class=\"fa fa-file\"></span> Document Type</th>";
        code = code + "\n<th width=\"40%\"><span class=\"fa fa-eye\"></span> View</th>";
        code = code + "\n<th width=\"30%\"><span class=\"fa fa-trash-o\"></span> Delete</th>";
        code = code + "\n</tr>";
        code = code + "\n</thead>";
        code = code + "\n</table>";
        code = code + "\n<div class=\"well well-sm\" id=\"fileUploadDiv\">";
        code = code + "\n<div class=\"text-primary h5\"><span class=\"fa fa-cloud-upload\"></span> File Upload</div>";
        code = code + "\n<div class=\"form-group\">";
        code = code + "\n<label class=\"col-md-3 col-xs-12 control-label\">File Section:</label>";
        code = code + "\n<div class=\"col-md-3 col-xs-12\" id=\"select-controller\">";
        code = code + "\n<input type=\"file\" class=\"fileinput btn-default\" name=\"file0\" id=\"file-select\"   title=\"Choose File From Disk\"/>";
        code = code + "\n</div>";
        code = code + "\n<div class=\"col-md-3 col-xs-12\">";
        code = code + "\n<button  class=\"btn btn-success\" id=\"upload-button\"><span class=\"fa fa-upload\"></span> Upload</button>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n</form>";
        code = code + "\n<div class=\"row\">";
        code = code + "\n<div class=\"col-md-15\">";
        code = code + "\n<div class=\"panel panel-default\">";
        code = code + "\n<div class=\"panel-body panel-body-table\">";
        code = code + "\n<div class=\"table-responsive\">";
        code = code + "\n";
        code = code + "\n<form action =\"${pageContext.request.contextPath}/ImageUpload\" method=\"post\">";
        code = code + "\n<table class=\"table\">";
        code = code + "\n<td>";
        code = code + "\n<input type =\"hidden\" name =\"template\"  value =\"<%=template%>\">";
        code = code + "\n<input type =\"hidden\" name =\"done\"  value =\"yes\">";
        code = code + "\n</td>";
        code = code + "\n<td></td>";
        code = code + "\n<td></td>";
        code = code + "\n<td></td>";
        code = code + "\n<td></td>";
        code = code + "\n<td></td>";
        code = code + "\n";
        code = code + "\n<td>";
        code = code + "\n<div class=\"col-md-3 col-xs-12\">";
        code = code + "\n<Button class=\"btn btn-success\" type=\"submit\"><span class=\"fa fa-send-o\"></span> Submit</Button>";
        code = code + "\n</div>";
        code = code + "\n</td>";
        code = code + "\n</table>";
        code = code + "\n</form>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n<p id=\"loghc\" style=\"height: 10px; display: none;\"> </p>";
        code = code + "\n</div>";
        code = code + "\n</div>";
        code = code + "\n<script>";
        code = code + "\nfunction renderElseWhere(id, loc) {";
        code = code + "\nvar paramValue = document.getElementById(id).value;";
        code = code + "\nvar print = '<img src=\"${pageContext.request.contextPath}/Initiator?paramValue=' + paramValue + '&paramName='+id+'&control=one\";\">';";
        code = code + "\ndocument.getElementById(loc).innerHTML = print";
        code = code + "\n}";
        code = code + "\n</script>";
        code = code + "\n<script>";
        code = code + "\nfunction renderElseWhere6(id, loc) {";
        code = code + "\nvar jobType = document.getElementById(id).value;";
        code = code + "\nvar print = '<img src=\"${pageContext.request.contextPath}/Initiator?jobType=' + jobType + '&imagecontrol=imageselect\";\">';";
        code = code + "\ndocument.getElementById(loc).innerHTML = print";
        code = code + "\n}";
        code = code + "\n</script>";
        code = code + "</div></div></div>";
        templateName = templateName.replace(" ", "_");
        int version = sb.getId("select version_no from template_names where template_name ='" + templateName + "'");
        version++;

        String result = sb.persist("update template_names set version_no =" + version + " where template_name ='" + templateName + "'");
        try {
            String path = "C:/DocumentManager/web/pages/";
            templateName = (String) session.getAttribute("template");
            path = path + templateName + "_" + version + ".jsp";
            FileUtils.writeStringToFile(new File(path), code);
        } catch (IOException ex) {
            Logger.getLogger(ConfigureJobController.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("message", templateName + " Successfully edited");
        request.setAttribute("status", "success");

        String dropTable = "drop table " + templateName.replace(" ", "_");
        String dropTableResult = new SaveToDb().persist(dropTable);

        String createTableQuerry = "create table " + templateName.replace(" ", "_") + "(";
        createTableQuerry = createTableQuerry + "\nref_id varchar2(100),";
        for (int i = 0; i < parameters.size(); i++) {
            if ("String".equalsIgnoreCase(parameters.get(i).getDatatype()) | "DROP_DOWN".equalsIgnoreCase(parameters.get(i).getDatatype()) | "DATE".equalsIgnoreCase(parameters.get(i).getDatatype())) {
                createTableQuerry = createTableQuerry + "\n" + parameters.get(i).getParameterName().trim().replace(" ", "_").toLowerCase() + " varchar2(100),";
            } else if (parameters.get(i).getDatatype().equalsIgnoreCase("Number")) {
                createTableQuerry = createTableQuerry + "\n" + parameters.get(i).getParameterName().trim().replace(" ", "_").toLowerCase() + " Number(17,2),";
            }
//            else if (parameters.get(i).getDatatype().equalsIgnoreCase("Date")) {
//                createTableQuerry = createTableQuerry + "\n" + parameters.get(i).getParameterName().trim().replace(" ", "_").toLowerCase() + " Date,";
//            }
        }
        createTableQuerry = createTableQuerry + "\nstatus varchar2(100),";
        createTableQuerry = createTableQuerry + "\nuploaded_by varchar2(100),";
        createTableQuerry = createTableQuerry + "\napproved_by varchar2(100),";
        createTableQuerry = createTableQuerry + "\nUploadDate timestamp default systimestamp,";//approved_status
        createTableQuerry = createTableQuerry + "\napproved_status varchar2(100),";
        createTableQuerry = createTableQuerry + "\ndirector_assigned varchar2(100),";
        createTableQuerry = createTableQuerry + "\nuser_assigned varchar2(100),";
        createTableQuerry = createTableQuerry + "\nuser_init varchar2(100),";
        createTableQuerry = createTableQuerry + "\ncontrol varchar2(100),";
        createTableQuerry = createTableQuerry + "\nprocessed varchar2(100),";
        createTableQuerry = createTableQuerry + "\naccess_control varchar2(20),";
        createTableQuerry = createTableQuerry + "\nCONSTRAINT " + templateName.replace(" ", "_") + "_pk PRIMARY KEY (ref_id)";
        createTableQuerry = createTableQuerry + "\n )";
        String createTableResult = new SaveToDb().persist(createTableQuerry);
        dropTable = "drop table params_table_" + templateName.replace(" ", "_");
        dropTableResult = new SaveToDb().persist(dropTable);
        createTableQuerry = "create table params_table_" + templateName.replace(" ", "_") + "(";
        createTableQuerry = createTableQuerry + "\nparam_names varchar2(100),";
        createTableQuerry = createTableQuerry + "\ntype varchar2(100)";
        createTableQuerry = createTableQuerry + "\n )";
        createTableResult = sb.persist(createTableQuerry);
        createTableQuerry = "create table param_values_" + templateName.replace(" ", "_") + "(";
        createTableQuerry = createTableQuerry + "\nparameter_name varchar2(100),";
        createTableQuerry = createTableQuerry + "\nparam_value varchar2(100)";
        createTableQuerry = createTableQuerry + "\n )";
        createTableResult = sb.persist(createTableQuerry);
        for (int i = 0; i < parameters.size(); i++) {
            String insertQuery = "insert into params_table_" + templateName.replace(" ", "_") + "(param_names, type) values('" + parameters.get(i).getParameterName().trim().replace(" ", "_").toLowerCase() + "', '" + parameters.get(i).getDatatype() + "')";
            sb.persist(insertQuery);
            if ("DROP_DOWN".equalsIgnoreCase(parameters.get(i).getDatatype())) {
                isDropDown = true;
            }
        }
        templateName = templateName.replace(" ", "_");
        String insertQuery = "insert into template_names(template_name, description) values('" + templateName + "', '" + (String) session.getAttribute("description") + "')";
        sb.persist(insertQuery);
        if (isDropDown) {
            List<String[]> params = sb.getListss("select param_names, type from params_table_" + templateName + "", 2);
            session.setAttribute("params", params);
            List<ParameterValues> newparams = new ArrayList<>();
            session.setAttribute("parameters", newparams);
            session.setAttribute("template", templateName);
            dispatch(request, response, "/pages/loadDropDownValues.jsp");
        } else {
            dispatch(request, response, "/pages/homepage.jsp");
        }  
    }

    
    public boolean configureAccess(HttpServletRequest request, HttpServletResponse response, List<AccessControl> accessControl)
    throws ServletException, IOException {
         boolean result = false;
          String res = "";
         SaveToDb sb = new SaveToDb();
         String query = "";
          sb.persist("delete from access_right where ref_id ='" + accessControl.get(0).getRef_id() + "'");
         for (AccessControl accessControl1 : accessControl) {
             if ( !"".equalsIgnoreCase(accessControl1.getAccess_key())) {
                query = "insert into access_right(access_key, access_nature, ref_id) values('" + accessControl1.getAccess_key() + "', '" + accessControl1.getAccess_nature() + "' , '" + accessControl1.getRef_id() + "')";
                res = sb.persist(query);
             }
            }
         if ("success".equalsIgnoreCase(res)) {
             result =true;
         }
         return result;
    }
    
    
    public boolean defineWorkFlow(HttpServletRequest request, HttpServletResponse response, List<DefineWorkFlowVo> defWorkFlowVo)
    throws ServletException, IOException {
         boolean result = false;
         String res = "";
         
         SaveToDb sb = new SaveToDb(); 
         HttpSession session = request.getSession(true);
         String template = (String) session.getAttribute("template");
         String query = "";
          sb.persist("delete from fas_work_flow_define  where template_name ='" + template + "'");
         for (DefineWorkFlowVo defWorkFlowVo1 : defWorkFlowVo) {
             String temp_auth_level = template+"tmpauthlv"+defWorkFlowVo1.getAuthLevel();
             if ( !"".equalsIgnoreCase(defWorkFlowVo1.getUserId()) && sb.isAvailable("select user_id from fas_mst_users where user_id = '" + defWorkFlowVo1.getUserId() + "'" )) {
                query = "insert into fas_work_flow_define (temp_auth_level, template_name , user_member  , auth_level ) values('" + temp_auth_level + "', '" + template + "', '" + defWorkFlowVo1.getUserId() + "' , '" + defWorkFlowVo1.getAuthLevel() + "')";
                res = sb.persist(query);
             }
            }
         if ("success".equalsIgnoreCase(res)) {
             result =true;
         }
         return result;
    }
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void dispatch(HttpServletRequest request, HttpServletResponse response, String destination) throws ServletException, IOException {
        RequestDispatcher view = request.getRequestDispatcher(destination);
        view.forward(request, response);
    }

}
