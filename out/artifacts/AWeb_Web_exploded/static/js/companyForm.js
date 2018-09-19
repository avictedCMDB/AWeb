function searchCompany(supID){
	var path = $("#path").val();
	var companyName = $("#companyName").val();
	window.location.href = path+"/supervise/company?companyName="+companyName+"&supID="+supID;
}