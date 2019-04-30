<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<script type="text/javascript">
/* Javascript 샘플 코드 */


var xhr = new XMLHttpRequest();
var url = 'http://openapi.tago.go.kr/openapi/service/SubwayInfoService/getSubwaySttnAcctoSchdulList'; /*URL*/
var queryParams = '?' + encodeURIComponent('ServiceKey') + '='+'FTsFabal6deoKxbke9kWGIb3kvMUFuKfJViCmlpItTmYPEDx1WeRTBx49otZympexcYXYzHV7c6obfhhawzocg%3D%3D'; /*Service Key*/
queryParams += '&' + encodeURIComponent('subwayStationId') + '=' + encodeURIComponent('SUB228'); /*지하철역ID*/
queryParams += '&' + encodeURIComponent('dailyTypeCode') + '=' + encodeURIComponent('03'); /*요일구분코드(01:평일, 02:토요일, 03:일요일)*/
queryParams += '&' + encodeURIComponent('upDownTypeCode') + '=' + encodeURIComponent('U'); /*상하행구분코드(U:상행, D:하행)*/
xhr.open('GET', url + queryParams);
xhr.onreadystatechange = function () {
    if (this.readyState == 4) {
        alert('Status: '+this.status+' Headers: '+JSON.stringify(this.getAllResponseHeaders())+' Body: '+this.responseText);
    }
};

xhr.send('');



</script>