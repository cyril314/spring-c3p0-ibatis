<!DOCTYPE HTML>
<html>
<jsp:include page="../head.jsp">
    <jsp:param name="title" value="我的桌面"/>
</jsp:include>
<body>
<div class="yadmin-body animated fadeIn">
    <h1>欢迎使用管理后台！</h1>
    <thead>
    <tr>
        <th colspan="2" scope="col">服务器信息</th>
    </tr>
    </thead>
    <table class="layui-table">
        <tr>
            <th width="30%">服务器计算机名</th>
            <td><span id="lbServerName">${os.computerName}</span></td>
        </tr>
        <tr>
            <td>服务器MAC</td>
            <td>${os.mac}</td>
        </tr>
        <tr>
            <td>服务器IP地址</td>
            <td>${os.ip}</td>
        </tr>
        <tr>
            <td>服务器端口</td>
            <td>${port}</td>
        </tr>
        <tr>
            <td>项目所在文件夹</td>
            <td>${os.itemPath}</td>
        </tr>
        <tr>
            <td>服务器操作系统</td>
            <td>${os.osname}</td>
        </tr>
        <tr>
            <td>用户工作目录</td>
            <td>${os.userdir}</td>
        </tr>
        <tr>
            <td>当前系统用户名</td>
            <td>${os.sysUserName}</td>
        </tr>
        <tr>
            <td>服务器当前时间</td>
            <td id="clock">${os.sysTime}</td>
        </tr>
        <tr>
            <td>服务器上次启动到现在已运行</td>
            <td id="runTime">${startDate}</td>
        </tr>
        <tr>
            <td>JAVA版本</td>
            <td>${os.java}</td>
        </tr>
        <tr>
            <td>虚拟机内存总量</td>
            <td>${os.vmRamTotal}</td>
        </tr>
        <tr>
            <td>当前程序占用内存</td>
            <td>${os.useRamTotal}</td>
        </tr>
    </table>
</div>
</body>
<script>
    window.onload = function () {
        let runTimeElement = document.getElementById("runTime");
        let runTime = runTimeElement.innerHTML.trim() !== "" ? new Date(runTimeElement.innerHTML) : new Date();
        //时间差的毫秒数
        let lag = new Date().getTime() - runTime.getTime();
        //计算出相差天数
        let days = Math.floor(lag / (24 * 3600 * 1000));
        //计算出小时数
        let hours = Math.floor((lag % (24 * 3600 * 1000)) / (3600 * 1000));
        document.getElementById("runTime").innerHTML = days + "天 " + hours + "小时 ";
    };
    setInterval(function () {
        document.getElementById("clock").innerHTML = new Date().Format("yyyy-MM-dd HH:mm:ss");
    }, 1000);
</script>
</html>