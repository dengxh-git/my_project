package com.sunline.sunfi.util;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class XSSRequestWrapper extends HttpServletRequestWrapper {

	public XSSRequestWrapper(HttpServletRequest request) {
		super(request);
		// TODO 自动生成的构造函数存根
	}

	@Override
    public String[] getParameterValues(String parameter) {
        String[] values = super.getParameterValues(parameter);
        if (values == null) {
            return null;
        }
        int count = values.length;
        String[] encodedValues = new String[count];
        for (int i = 0; i < count; i++) {
            encodedValues[i] = stripXSS(values[i]);
        }
        return encodedValues;
    }
    @Override
    public String getParameter(String parameter) {
        String value = super.getParameter(parameter);
        String value_ = stripXSS(value);
        if(value_ != null){
        	while(value_.indexOf("<script>")>-1){
            	value_ = value_.replaceAll("<script>", "");
            }
        	while(value_.indexOf("</script>")>-1){
            	value_ = value_.replaceAll("</script>", "");
            }
        }
        return encode(value_);
    }
    @Override
    public String getHeader(String name) {
        String value = super.getHeader(name);
        return stripXSS(value);
    }
    private String stripXSS(String value) {
        if (value != null) {
            // NOTE: It's highly recommended to use the ESAPI library and uncomment the following line to
            // avoid encoded attacks.
            // value = ESAPI.encoder().canonicalize(value);
            // Avoid null characters
            value = value.replaceAll("", "");
            // Avoid anything between script tags
            Pattern scriptPattern = Pattern.compile("<script>(.*?)</script>", Pattern.CASE_INSENSITIVE);
            value = scriptPattern.matcher(value).replaceAll("");
            // Avoid anything in a src="..." type of e­xpression
            scriptPattern = Pattern.compile("src[\r\n]*=[\r\n]*\\\'(.*?)\\\'", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
            value = scriptPattern.matcher(value).replaceAll("");
            scriptPattern = Pattern.compile("src[\r\n]*=[\r\n]*\\\"(.*?)\\\"", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
            value = scriptPattern.matcher(value).replaceAll("");
            // Remove any lonesome </script> tag
            scriptPattern = Pattern.compile("</script>", Pattern.CASE_INSENSITIVE);
            value = scriptPattern.matcher(value).replaceAll("");
            // Remove any lonesome <script ...> tag
            scriptPattern = Pattern.compile("<script(.*?)>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
            value = scriptPattern.matcher(value).replaceAll("");
            // Avoid eval(...) e­xpressions
            scriptPattern = Pattern.compile("eval\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
            value = scriptPattern.matcher(value).replaceAll("");
            // Avoid e­xpression(...) e­xpressions
            scriptPattern = Pattern.compile("e­xpression\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
            value = scriptPattern.matcher(value).replaceAll("");
            // Avoid javascript:... e­xpressions
            scriptPattern = Pattern.compile("javascript:", Pattern.CASE_INSENSITIVE);
            value = scriptPattern.matcher(value).replaceAll("");
            // Avoid vbscript:... e­xpressions
            scriptPattern = Pattern.compile("vbscript:", Pattern.CASE_INSENSITIVE);
            value = scriptPattern.matcher(value).replaceAll("");
            // Avoid onload= e­xpressions
            scriptPattern = Pattern.compile("onload(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
            value = scriptPattern.matcher(value).replaceAll("");
        }
        return value;
    }
    
    private String encode(String input) {
        if (input == null) {
            return input;
        }
        StringBuilder sb = new StringBuilder(input.length());
        for (int i = 0, c = input.length(); i < c; i++) {
            char ch = input.charAt(i);
            switch (ch) {
                case '&': sb.append("&amp;");
                    break;
                case '<': sb.append("&lt;");
                    break;
                case '>': sb.append("&gt;");
                    break;
                case '"': sb.append("&quot;");
                    break;
                case '\'': sb.append("&#x27;");
                    break;
                case '/': sb.append("&#x2F;");
                    break;
                default: sb.append(ch);
            }
        }
        return sb.toString();
    }
}
