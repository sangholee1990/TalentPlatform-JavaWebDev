package com.gaia3d.web.util;

/*
 * Copyright 2008 Ayman Al-Sairafi ayman.alsairafi@gmail.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License
 *       at http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * 
 * http://www.java2s.com/Code/Java/Reflection/Findasettermethodforthegiveobjectspropertyandtrytocallit.htm
 * 
 */

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Member;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.gaia3d.web.dto.wmo.MD_Metadata;

/**
 * Reflection Utility methods
 * 
 * @author Ayman Al-Sairafi
 */
public class ReflectUtils {
   
	private static final Logger logger = LoggerFactory.getLogger(ReflectUtils.class);
			
	public static void main(String[] args) throws Exception {
		MD_Metadata m = new MD_Metadata();
	
		System.out.println("1---" + m.getMetadataseqn());
		
		ReflectUtils.callSetter(m, "metadataseqn", 1);
		
		System.out.println("2---" + m.getMetadataseqn());
	}

    /**
     * Find a setter method for the give object's property and try to call it.
     * No exceptions are thrown. You typically call this method because either
     * you are sure no exceptions will be thrown, or to silently ignore
     * any that may be thrown.
     * This will also find a setter that accepts an interface that the value
     * implements.
     * <b>This is still not very effcient and should only be called if
     * performance is not of an issue.</b>
     * You can check the return value to see if the call was seuccessful or
     * not.
     * @param obj Object to receive the call
     * @param property property name (without set. First letter will be
     * capitalized)
     * @param value Value of the property.
     * @return
     */
    public static boolean callSetter(Object obj, String property, Object value) {
        String key = String.format("%s.%s(%s)", obj.getClass().getName(),
                property, value.getClass().getName());
        Method m = null;
        boolean result = false;
        if(!SETTERS_MAP.containsKey(key)) {
            m = findMethod(obj, property, value);
            SETTERS_MAP.put(key, m);
        } else {
            m = SETTERS_MAP.get(key);
        }
        if(m != null) {
            try {
                m.invoke(obj, value);
                result = true;
            } catch (IllegalAccessException ex) {
                logger.debug(ReflectUtils.class.getName() + ex.toString());
            } catch (IllegalArgumentException ex) {
                logger.debug(ReflectUtils.class.getName() + ex.toString());
            } catch (InvocationTargetException ex) {
                logger.debug(ReflectUtils.class.getName() + ex.toString());
            }
        }
        return result;
    }



    /**
     * Scans all classes accessible from the context class loader which belong to the given package and subpackages.
     *
     * @param packageName The base package
     * @return The classes
     * @throws ClassNotFoundException
     * @throws IOException
     */
    private static Class[] getClasses(String packageName)
            throws ClassNotFoundException, IOException {
//        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        ClassLoader classLoader = ClassLoader.getSystemClassLoader();
        assert classLoader != null;
        String path = packageName.replace('.', '/');
        Enumeration<URL> resources = classLoader.getResources(path);
        List<File> dirs = new ArrayList<File>();
        while (resources.hasMoreElements()) {
            URL resource = resources.nextElement();
            dirs.add(new File(resource.getFile()));
        }
        ArrayList<Class> classes = new ArrayList<Class>();
        for (File directory : dirs) {
            classes.addAll(findClasses(directory, packageName));
        }
        return classes.toArray(new Class[classes.size()]);
    }

    /**
     * Recursive method used to find all classes in a given directory and subdirs.
     *
     * @param directory   The base directory
     * @param packageName The package name for classes found inside the base directory
     * @return The classes
     * @throws ClassNotFoundException
     */
    private static List<Class> findClasses(File directory, String packageName) throws ClassNotFoundException {
        List<Class> classes = new ArrayList<Class>();
        if (!directory.exists()) {
            return classes;
        }
        File[] files = directory.listFiles();
        for (File file : files) {
            if (file.isDirectory()) {
                assert !file.getName().contains(".");
                classes.addAll(findClasses(file, packageName + "." + file.getName()));
            } else if (file.getName().endsWith(".class")) {
                classes.add(Class.forName(packageName + '.' + file.getName().substring(0, file.getName().length() - 6)));
            }
        }
        return classes;
    }


    private static synchronized Method findMethod(Object obj,
            String property, Object value) {
        Method m = null;
        Class<?> theClass = obj.getClass();
        String setter = String.format("set%C%s",
                property.charAt(0), property.substring(1));
        Class paramType = value.getClass();
        while (paramType != null) {
            try {
                m = theClass.getMethod(setter, paramType);
                return m;
            } catch (NoSuchMethodException ex) {
                // try on the interfaces of this class
                for (Class iface : paramType.getInterfaces()) {
                    try {
                        m = theClass.getMethod(setter, iface);
                        return m;
                    } catch (NoSuchMethodException ex1) {
                    }
                }
                paramType = paramType.getSuperclass();
            }
        }
        return m;
    }
    public static final List<String> DEFAULT_PACKAGES = new ArrayList<String>(3);

    static {
        DEFAULT_PACKAGES.add("java.lang");
        DEFAULT_PACKAGES.add("java.util");
        DEFAULT_PACKAGES.add("jsyntaxpane");
    }
    /**
     * To speed up find setter methods, this map will be used.
     * The Key String will be of the format objectClass.property(valueclass)
     * Where:
     * objectClass = obj.getClass().getName
     * property = property (as passed in to callSetter), before set is appended
     * valueCLass = value.getClass().getName()
     * The Method will be either the method, or null if a search was not and no
     * method is found.
     */
    private static HashMap<String, Method> SETTERS_MAP = new HashMap<String, Method>();

}

   
