# mydalgen
mybatis dalgen command-line tool

本工具可以自动生成DAL层代码，主要是封装了 mybatis-generator 工具

## 使用方式
> 前置依赖 
> 1. Linux 或 MacOS
> 2. python java
 
> Windows 用户请直接执行 jar 文件: `java -jar mydalgen-1.0.2-all.jar -c generatorConfig.xml -o true`

1. 下载[最新版本](https://github.com/terasum/mydalgen/releases/)的发布包

2. 解压至任意路径
```shell
tar zxf mydalgen.tar.gz -C yourpath
```
3. 进入解压出来之后的路径即可使用
```shell
cd mydalgen-v1.0.2
chmod a+x mydalgen

mydalgen -c generatorConfig.xml -o true
# -c 为生成配置
# -o 是否覆盖现有生成文件
```
4. 在 webapp 项目的 pom.xml 文件当中，加入如下依赖：
注意: 下面的版本都是比较新的版本，mydalgen 就是依赖这些版本的，建议保持一致(2022-01-10)

```xml
        <!--mybatis-->
        <dependency>
            <groupId>org.mybatis.spring.boot</groupId>
            <artifactId>mybatis-spring-boot-starter</artifactId>
            <version>2.2.0</version>
            <exclusions>
                <exclusion>
                    <groupId>ch.qos.logback</groupId>
                    <artifactId>logback-classic</artifactId>
                </exclusion>
            </exclusions>
        </dependency>
        <!--mapper-->
        <dependency>
            <groupId>tk.mybatis</groupId>
            <artifactId>mapper-spring-boot-starter</artifactId>
            <version>1.2.4</version>
        </dependency>
        <!--pagehelper-->
        <dependency>
            <groupId>com.github.pagehelper</groupId>
            <artifactId>pagehelper-spring-boot-starter</artifactId>
            <version>1.4.1</version>
            <exclusions>
                <exclusion>
                    <groupId>ch.qos.logback</groupId>
                    <artifactId>logback-classic</artifactId>
                </exclusion>
            </exclusions>
        </dependency>
```

## generatorConfig.xml 说明

完整 generatorConfig.xml:
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE generatorConfiguration PUBLIC
        "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd" >

<generatorConfiguration>
    <context id="MysqlContext" targetRuntime="MyBatis3Simple" defaultModelType="flat">
        <!--定义生成的java类的编码格式-->
        <property name="javaFileEncoding" value="UTF-8"/>

        <property name="beginningDelimiter" value="`"/>
        <property name="endingDelimiter" value="`"/>

        <!-- 通用mapper 插件 -->
        <plugin type="tk.mybatis.mapper.generator.MapperPlugin">
            <property name="mappers" value="tk.mybatis.mapper.common.Mapper"/>
            <property name="caseSensitive" value="true"/>
        </plugin>

        <!--suppressAllComments 设置为true 则不再生成注释-->
        <commentGenerator>
            <property name="suppressAllComments" value="false"/>
        </commentGenerator>

        <jdbcConnection driverClass="com.mysql.cj.jdbc.Driver"
                        connectionURL="jdbc:mysql://localhost:3306/example"
                        userId="root"
                        password="123456">
        </jdbcConnection>

        <javaTypeResolver>
            <property name="forceBigDecimals" value="false"/>
        </javaTypeResolver>

        <!-- 实体类生成的位置 -->
        <javaModelGenerator targetPackage="com.chainlark.datatar.common.dal.model"
                            targetProject="target/src/main/java"/>

        <!-- 对应生成的 mapper.xml 所在目录 -->
        <sqlMapGenerator targetPackage="mapper" targetProject="target/src/main/resources"/>

        <!-- 配置 mapper 接口的位置 -->
        <javaClientGenerator targetPackage="com.chainlark.datatar.common.dal.mapper"
                         targetProject="target/src/main/java" type="XMLMAPPER"/>

        <!-- 如果想生成全部表用  tableName="%" -->
        <!-- table指定每个生成表的生成策略  表名 和 model实体类名-->
        <table tableName="cl_article" domainObjectName="Article" enableSelectByExample="true"
               enableDeleteByExample="true" enableCountByExample="true"
               enableUpdateByExample="true" selectByExampleQueryId="true">
            <property name="ignoreQualifiersAtRuntime" value="false"/>
            <property name="useActualColumnNames" value="false"/>
        </table>

        <table tableName="cl_user" domainObjectName="User" enableSelectByExample="true"
               enableDeleteByExample="true" enableCountByExample="true"
               enableUpdateByExample="true" selectByExampleQueryId="true">
            <property name="ignoreQualifiersAtRuntime" value="false"/>
            <property name="useActualColumnNames" value="false"/>
        </table>
    </context>
</generatorConfiguration>
```

注意，配置文件内各个配置项的顺序不可以修改，否则会报错

## 想要随处可用?
如果想作为命令行工具随处可用，可参考如下步骤
1. 将下载解压后的包工具存放在 `$HOME/.local/lib && chmod +x $HOME/.local/lib/mydalgen-v1.0.2/mydalgen`
2. `ln -sf $HOME/.local/lib/mydalgen-v1.0.2/mydalgen $HOME/.local/bin/mydalgen`
3. `echo $PATH=$PATH:$HOME/.local/bin >> $HOME/.bashrc # or .zshrc`
