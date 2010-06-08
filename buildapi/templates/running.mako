<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>List of running builds</title>
${h.tags.javascript_link(
    url('/jquery/js/jquery-1.4.2.min.js'),
    url('/jquery/js/jquery-ui-1.8.1.custom.min.js'),
    url('/dataTables-1.6/media/js/jquery.dataTables.min.js'),
    )}
<style type="text/css">
@import "${url('/jquery/css/smoothness/jquery-ui-1.8.1.custom.css')}";
@import "${url('/dataTables-1.6/media/css/demo_page.css')}";
@import "${url('/dataTables-1.6/media/css/demo_table_jui.css')}";
</style>
<script type="text/javascript">
$(document).ready(function() {
    $("#pending").dataTable({
        "bJQueryUI": true,
        "iDisplayLength": 25,
        "sPaginationType": "full_numbers",
        "aaSorting": [[0,'asc'],[1,'asc'],[3,'desc'],[2,'asc']],
      } );

});

</script>
</head>

<body>
<div class="demo_jui">
<table id="pending" cellpadding="0" cellspacing="0" border="0" class="display">
<thead>
<tr>
% for key in ('Branch','Revision','Builder name','Submitted at', 'Running since','Running for','Master'):
<th>${key}</th>
% endfor
</tr></thead><tbody>
<%
  from datetime import datetime
  now = datetime.now()
  now = now.replace(now.year,now.month,now.day,now.hour,now.minute,now.second,0)
%>
% for branch in c.running_builds:
  % for revision in c.running_builds[branch]:
    % for build in c.running_builds[branch][revision]:
      <%
        build['submitted_at_human'] = datetime.fromtimestamp(build['submitted_at']).strftime('%Y-%m-%d %H:%M:%S')
        build['start_time_human'] = datetime.fromtimestamp(build['start_time']).strftime('%Y-%m-%d %H:%M:%S')
        build['running_for'] = now - datetime.fromtimestamp(build['start_time'])
        build['master'] = build['claimed_by_name'].split('.')[0]
      %>
      <tr>
      % for key in ('branch','revision','buildername','submitted_at','start_time','running_for','master'):
        % if key == 'submitted_at':
          <td title='${build['submitted_at']}'>${build['submitted_at_human']}</td>
        % elif key == 'start_time':
          <td title='${build['start_time']}'>${build['start_time_human']}</td>
        % else:
          <td>${build[key]}</td>
        % endif
      % endfor
      </tr>
    % endfor
  % endfor
%endfor
</tbody><table>

</body>
</html>
Generated at ${now}. All times are Pacific time (Mountain View).