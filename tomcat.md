#1. config path directory
	1). conf/service.xml add <Context docBase="D:\web-server\apache-tomcat-10.0.27\demo" path="/demo" /> in <Host> tag
	2). conf/Catalina/locahost/ add demo.xml, the content like: <Context docBase="D:\web-server\apache-tomcat-10.0.27\demo" path="/demo" />

#2. servlet readme
	import javax.servlet.*;
	public class servletDemo implements Servlet {
		@Override
	    public void service(ServletRequest servletRequest, ServletResponse servletResponse) throws ServletException, IOException {
	        System.out.println("hello");
	    }
	}

	web.xml add content:
	<servlet>
        <servlet-name>servlet-demo</servlet-name>
        <servlet-class>com.servlet.servletDemo</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>servlet-demo</servlet-name>
        <url-pattern>/servlet-demo-url</url-pattern>
    </servlet-mapping>

    http://localhost:8080/servlet/servlet-demo-url to visit {servlet is tomcat server Application context}

#3. 