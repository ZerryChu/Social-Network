package group.zerry.api_server.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author：刘志龙
 * @since：2014年12月4日 下午2:41:33
 * @version:1.0
 */

@Documented
@Inherited @Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface AuthPass {

	boolean validate() default true;
}
