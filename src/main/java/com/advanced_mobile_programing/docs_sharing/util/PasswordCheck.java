package com.advanced_mobile_programing.docs_sharing.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class PasswordCheck {
    public boolean validatePassword(String password) {
        String regex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$";
        /*
         * Giải thích biểu thức chính quy:
         * ^                Bắt đầu của chuỗi
         * (?=.*[0-9])      Ít nhất một chữ số
         * (?=.*[a-z])      Ít nhất một chữ thường
         * (?=.*[A-Z])      Ít nhất một chữ hoa
         * (?=.*[@#$%^&+=])   Ít nhất một ký tự đặc biệt
         * (?=\S+$)         Không có khoảng trắng
         * .{8,}            Ít nhất 8 ký tự
         * $                Kết thúc của chuỗi
         */

        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(password);
        return matcher.matches();
    }
}
