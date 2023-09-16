package config;

import org.apache.tomcat.jdbc.pool.*;
import org.springframework.context.annotation.*;
import org.springframework.jdbc.datasource.*;
import org.springframework.transaction.*;
import org.springframework.transaction.annotation.*;
import svc.*;
import dao.*;

@Configuration
@EnableTransactionManagement
public class MemberConfig {
	@Bean(destroyMethod = "close")
	public DataSource dataSource() {
		DataSource ds = new DataSource();
		ds.setDriverClassName("com.mysql.jdbc.Driver");
		ds.setUrl("jdbc:mysql://localhost/goods0902?characterEncoding=utf8");
		ds.setUsername("goods0902");
		ds.setPassword("wlsgnldms0902@");
		ds.setInitialSize(2);
		ds.setMaxActive(10);
		ds.setTestWhileIdle(true);
		ds.setMinEvictableIdleTimeMillis(60000 * 3);
		ds.setTimeBetweenEvictionRunsMillis(10 * 1000);
		return ds;
	}
	@Bean
	public PlatformTransactionManager transactionManager() {
		DataSourceTransactionManager tm = new DataSourceTransactionManager();
		tm.setDataSource(dataSource());
		return tm;
	}

	@Bean
	public MemberDao memberDao() {
		return new MemberDao(dataSource());
	}
	@Bean
	public MemberLoginSvc memberLoginSvc() {
		return new MemberLoginSvc(memberDao());
	}
	@Bean
	public ProductDao productDao() {
		return new ProductDao(dataSource());
	}
	@Bean
	public ProductSvc productSvc() {
		return new ProductSvc(productDao());
	}
	@Bean
	public OrderSvc orderSvc() {
		return new OrderSvc(orderDao());
	}
	@Bean
	public OrderDao orderDao() {
		return new OrderDao(dataSource());
	}

	@Bean
	public CartSvc cartSvc() {
		return new CartSvc(orderDao());
	}
	@Bean
	public MypageSvc mypageSvc() {
		return new MypageSvc(mypageDao());
	}
	@Bean
	public MypageDao mypageDao() {
		return new MypageDao(dataSource());
	}
	@Bean
	public EventSvc eventSvc() {
		return new EventSvc(eventDao());
	}
	@Bean
	public EventDao eventDao() {
		return new EventDao(dataSource());
	}
	@Bean
	public MainSvc mainSvc() {
		return new MainSvc(mainDao());
	}
	@Bean
	public MainDao mainDao() { 
		return new MainDao(dataSource());
	}
	@Bean
	public ArtistDao artistDao() { 
		return new ArtistDao(dataSource());
	}
	@Bean
	public ArtistSvc artistSvc() {
		return new ArtistSvc(artistDao());
	}
	@Bean
	public NoticeDao noticeDao() { 
		return new NoticeDao(dataSource());
	}
	@Bean
	public NoticeSvc noticeSvc() {
		return new NoticeSvc(noticeDao());
	}




	
}	
