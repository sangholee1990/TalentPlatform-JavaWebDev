package com.gaia3d.web.constraints;

import java.util.ArrayList;
import java.util.List;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class StringValidator implements ConstraintValidator<ValidateString, String>{

    private List<String> valueList;

    @Override
    public void initialize(ValidateString constraintAnnotation) {
        valueList = new ArrayList<String>();
        for(String val : constraintAnnotation.acceptedValues()) {
            valueList.add(val.toUpperCase());
        }
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
    	if(value == null)
    		return true;
    	
        if(!valueList.contains(value.toUpperCase())) {
            return false;
        }
        return true;
    }

}