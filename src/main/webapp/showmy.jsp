<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import=" java.io.IOException"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Referals</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>
<table id="preset_display">
			<tr>
				<th>Company Name</th>
				<th>Job Type</th>
				<th>Job Role</th>
				<th>Job ID</th>
				<th>Remove</th>
				
			</tr>

<%
			Class.forName("com.mysql.cj.jdbc.Driver");
			String connectionURL = "jdbc:mysql://localhost:3306/project_refernow";
			String user = "root";
			String pass = "keny@9180";
			int result = 0;
			Connection con = null;
			try
			{
				con=DriverManager.getConnection(connectionURL,user,pass);
				Statement st = con.createStatement();
				ResultSet presets = st.executeQuery("select * from referal");
				while(presets.next())
				{
					
					String cn = presets.getString("comp_name");
					String jt = presets.getString("job_type");
					String jr = presets.getString("job_role");
					String jd = presets.getString("job_id");
					int i = presets.getInt("ref_id");
					
					%>
			<tr>
				<td><%=cn %></td>
				<td><%=jt %></td>
				<td><%=jr %></td>
				<td><%=jd %></td>
				
				<td><button type="button" id="<%=i%>" class="deletep">Delete</button></td>
			</tr>
					
			<%
			}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			finally
			{
				if(con!=null)
					con.close();
				
			}
			%>	
		</table>
		

</body>
<script>

			$(document).ready(function() {
				// crating new click event for save button
				$(".deletep").click(function() {
					var id = +this.id;
					$.ajax({
						url: "delete.jsp",
						type: "post",
						data: {
							id : id,
						},
						success : function(data){
							alert("Deleted Successfully"); // alerts the response from jsp
							location.reload();
						}
					});
				});
			});
		</script>
</html>