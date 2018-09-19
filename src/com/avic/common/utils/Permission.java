package com.avic.common.utils;

import javax.servlet.http.HttpSession;

import com.avic.common.constants.SessionKeys;
import com.avic.common.constants.UserRole;
import com.avic.common.exceptions.NoPermissionException;
import com.avic.common.exceptions.UserNotLoginException;
import com.avic.passport.models.User;

public class Permission {
    public static User check(HttpSession session, UserRole role) {
        User user = (User)session.getAttribute(SessionKeys.LOGIN_USER);
        if (user == null) {
            throw new UserNotLoginException();
        }
        
        /*if (role != UserRole.NONE && !user.getAuthorities().contains(role.value())) {
            throw new NoPermissionException();
        }*/        
     
        return user;
    }
    public static User check(HttpSession session, UserRole role1, UserRole role2) {
        User user = (User)session.getAttribute(SessionKeys.LOGIN_USER);
        if (user == null) {
            throw new UserNotLoginException();
        }
        
        /*if (!user.getAuthorities().contains(role1.value()) && !user.getAuthorities().contains(role2.value())) {
            throw new NoPermissionException();
        }*/        
     
        return user;
    }
}
