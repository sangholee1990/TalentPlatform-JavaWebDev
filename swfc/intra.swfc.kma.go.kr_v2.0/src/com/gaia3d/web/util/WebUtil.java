package com.gaia3d.web.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

public final class WebUtil

{

   /**

     * Creates a Map of query string key and value parameters from the

     * given request

     * 

     * @param request the request

     * 

     * @return the query string map
 * @throws UnsupportedEncodingException 

     */

   public static Map<String, String> buildQueryStringMap(HttpServletRequest request) throws UnsupportedEncodingException

   {

       return buildQueryStringMap(request.getQueryString());

   }

   

   /**

     * Creates a Map of query string key and value parameters from the

     * given query string.

     * 

     * @param queryString the query string

     * 

     * @return the query string map
 * @throws UnsupportedEncodingException 

     */    

   public static Map<String, String> buildQueryStringMap(String queryString) throws UnsupportedEncodingException

   {

       final Map<String, String> map = new HashMap<String, String>(8, 1.0f);

       

       if (queryString != null)

       {

           for (final StringTokenizer t = new StringTokenizer(queryString, "&"); t.hasMoreTokens(); /**/)

            {

                final String combo = t.nextToken();

                final int c = combo.indexOf('=');

                if (c > -1)

                {

                    String value = URLDecoder.decode(combo.substring(c + 1, combo.length()), "UTF-8");

                    map.put(combo.substring(0, c), value);

                }

            }

        }

        

        return map;        

    }

 

    /**

     * Returns the query string for a given map of key and value pairs

     * 

     * @param map the map

     * 

     * @return the query string for map, never null
     * @throws UnsupportedEncodingException 

     */

   public static String getQueryStringForMap(final Map<String, String> map) throws UnsupportedEncodingException
   {
       if (map == null)
       {
           return "";
       }

       final StringBuilder result = new StringBuilder(32);
       for (String key : map.keySet())
       {
           String value = URLEncoder.encode( map.get(key), "UTF-8");
           if (result.length() != 0)
           {
               result.append('&');
           }
           result.append(key).append('=').append(value);
       }
       return result.toString();
   }
}
