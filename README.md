# mydalgen
mybatis dalgen command-line tool

本工具可以自动生成DAL层代码，主要是封装了 mybatis-generator 工具

## 使用方式
> 前置依赖 
> 1. Linux 或 MacOS
> 2. python java
 
> Windows 用户请直接执行 jar 文件: `java -jar mydalgen-1.0.1-all.jar -c generatorConfig.xml -o true`

3. 下载[最新版本](https://github.com/terasum/mydalgen/releases/)的发布包

4. 解压至任意路径
```shell
tar zxf mydalgen.tar.gz -C yourpath
```
3. 进入解压出来之后的路径即可使用
```shell
cd mydalgen-v1.0.1
chmod a+x mydalgen

mydalgen -c generatorConfig.xml -o true
# -c 为生成配置
# -o 是否覆盖现有生成文件
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

        <!-- 通用mapper所在目录 -->
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
1. 将下载解压后的包工具存放在 `$HOME/.local/lib`
2. `ln -sf $HOME/.local/lib/mydalgen-v1.0.1/mydalgen $HOME/.local/bin/mydalgen`
3. `echo $PATH=$PATH:$HOME/.local/bin >> $HOME/.bashrc # or .zshrc`
