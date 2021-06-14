package com.example.delivery_food_back_end.configuration;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("*")
public class Filter implements javax.servlet.Filter
{

    @Override
    public void init(FilterConfig filterConfig) throws ServletException
    {
        javax.servlet.Filter.super.init(filterConfig);
    }

    @Override
    public void destroy()
    {
        javax.servlet.Filter.super.destroy();
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException
    {
        var a = (HttpServletResponse) servletResponse;
        a.addHeader("Access-Control-Allow-Origin", "*");
        a.addHeader("Access-Control-Allow-Credentials", "true"); // Required for cookies, authorization headers with HTTPS
        a.addHeader("Access-Control-Allow-Headers", "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale");
        a.addHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");

        filterChain.doFilter(servletRequest, servletResponse);
    }
}



