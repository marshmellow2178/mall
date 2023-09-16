package config;

import org.springframework.context.annotation.*;
import org.springframework.web.servlet.config.annotation.*;

@Configuration  // 스프링 설정 클래스로 사용한다는의미의 애노테이션
@EnableWebMvc	// 스프링 MVC 설정을 활성화하는 애노테이션
public class MakeConfig implements WebMvcConfigurer {
	@Override
	public void configureDefaultServletHandling(
			DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}// 매핑 경로를 처리하기 윈한 메소드
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
	// view에서 보여줄 jsp파일에 대한 위치 및(접두어) 접미사(접미어)에 대한 설정을 하는 메소드	
		registry.jsp("/WEB-INF/view/",".jsp"); // 
	}
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
	// 특정 작업없이 단순히 연결만 할 경우 컨트롤러를 따로 만드는 것이 아닌
	// addViewControllers() 메소드를 사용하여 요청경로와 뷰이름을 연결	
		registry.addViewController("/main").setViewName("main");
		
	}
}
