package com.advanced_mobile_programing.docs_sharing.config;

import com.advanced_mobile_programing.docs_sharing.exception_handler.AccessDeniedHandler;
import com.advanced_mobile_programing.docs_sharing.exception_handler.UnauthorizedHandler;
import com.advanced_mobile_programing.docs_sharing.filter.GlobalCorsFilter;
import com.advanced_mobile_programing.docs_sharing.filter.JWTAuthenticationFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.context.NullSecurityContextRepository;
import org.springframework.security.web.context.SecurityContextRepository;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final JWTAuthenticationFilter jwtAuthenticationFilter;
    private final AuthenticationProvider authenticationProvider;
    private final GlobalCorsFilter globalCorsFilter;

    @Autowired
    public SecurityConfig(JWTAuthenticationFilter jwtAuthenticationFilter, AuthenticationProvider authenticationProvider, GlobalCorsFilter globalCorsFilter) {
        this.jwtAuthenticationFilter = jwtAuthenticationFilter;
        this.authenticationProvider = authenticationProvider;
        this.globalCorsFilter = globalCorsFilter;
    }

    @Bean
    public AccessDeniedHandler accessDenied() {
        return new AccessDeniedHandler();
    }

    @Bean
    public UnauthorizedHandler unauthorized() {
        return new UnauthorizedHandler();
    }

    @Bean
    public SecurityContextRepository securityContextRepository() {
        return new NullSecurityContextRepository(); // I use Null Repository since I don't need it for anything except store information in UserDetails
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable()) // Xem xét lại nếu bị lỗi 403

                .anonymous(anonymous -> anonymous.disable())

                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))

                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(
                                "/api/v1/swagger-ui",
                                "/api/v1/swagger-ui/**",
                                "/api/v1/api-docs",
                                "/api/v1/api-docs/**").permitAll()

                        .requestMatchers(
                                "/api/v1/auth/*").permitAll()

                        .requestMatchers(
                                "/api/v1/users/password/reset").permitAll()

                        .requestMatchers(
                                "/api/v1/users/password/reset",
                                "/api/v1/users/password",
                                "/api/v1/users/profile",
                                "/api/v1/users/avatar",
                                "/api/v1/users/password/reset").hasAuthority("ROLE_STUDENT")
                        .requestMatchers(
                                "/api/v1/users/*").hasAuthority("ROLE_ADMIN")

                        .requestMatchers(
                                "/api/v1/post/**").authenticated()

                        .requestMatchers(
                                "/api/v1/document/**").authenticated()

                        .anyRequest().authenticated())

                .securityContext((securityContext) -> securityContext.securityContextRepository(securityContextRepository())) // Add Security Context Holder Repository
                .authenticationProvider(authenticationProvider)
                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
                .addFilterBefore(globalCorsFilter, UsernamePasswordAuthenticationFilter.class)
                .exceptionHandling(exception -> exception
                        .accessDeniedHandler(accessDenied())
                        .authenticationEntryPoint(unauthorized())
                )
                .httpBasic(Customizer.withDefaults())
        ;
        return http.build();
    }
}
