package com.advanced_mobile_programing.docs_sharing.config;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.sun.security.auth.UserPrincipal;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.DefaultHandshakeHandler;

import java.security.Principal;
import java.util.Map;

import static org.springframework.http.HttpHeaders.AUTHORIZATION;

public class UserHandshakeHandler extends DefaultHandshakeHandler {
    @Value("${API_KEY}")
    private String SECRET_KEY;

    @Override
    protected Principal determineUser(ServerHttpRequest request, WebSocketHandler wsHandler, Map<String, Object> attributes) {
        String authorizationHeader = request.getHeaders().getFirst(AUTHORIZATION);
        String userName = "";
        if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
            String token = authorizationHeader.substring("Bearer ".length());
            if (token.length() > 0) {
                Algorithm algorithm = Algorithm.HMAC256(SECRET_KEY.getBytes());
                JWTVerifier verifier = JWT.require(algorithm).build();
                DecodedJWT decodedJWT = verifier.verify(token);
                userName = decodedJWT.getSubject();
            }
        }
        return new UserPrincipal(userName);
    }
}
