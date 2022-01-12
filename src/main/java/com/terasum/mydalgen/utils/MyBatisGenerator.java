package com.terasum.mydalgen.utils;

import org.apache.commons.cli.*;
import org.mybatis.generator.api.ProgressCallback;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * @author chenquan
 */
public class MyBatisGenerator {
    private static final Logger LOG = LoggerFactory.getLogger(MyBatisGenerator.class);

  public static void main(String[] args) {

    Options options = new Options();
    Option configFile = new Option("c", "configfile", true, "configuration file");
    configFile.setRequired(true);
    options.addOption(configFile);

    Option override = new Option("o", "override", true, "override flag");
    override.setRequired(false);
    options.addOption(override);

    CommandLineParser parser = new PosixParser();
    HelpFormatter formatter = new HelpFormatter();
    // not a good practice, it serves it purpose
    CommandLine cmd = null;

    try {
      cmd = parser.parse(options, args);
    } catch (ParseException e) {
      System.out.println(e.getMessage());
      System.out.println();
      formatter.printHelp("mydalgen", options);
      System.out.println("usage example: java -jar dalgenx.jar - -c generatorConfig.xml -o true");
      System.exit(1);
    }

    String configFilePath = cmd.getOptionValue("configfile");
    String overrideFlag = cmd.getOptionValue("override", "false");
    LOG.info("generator config file: " + configFilePath);
    LOG.info("override flag: " + overrideFlag);
    boolean isOverride = "true".equalsIgnoreCase(overrideFlag);


    		try {
    			MyBatisGenerator.generator(configFilePath, isOverride);
    		} catch (Exception e) {
    			e.printStackTrace();
    		}

  }

  public static void generator(String configFilePath, boolean isOverride) throws Exception {

    List<String> warnings = new ArrayList<String>();
    // 指定 逆向工程配置文件
    File configFile = new File(configFilePath);
    ConfigurationParser cp = new ConfigurationParser(warnings);
    Configuration config = cp.parseConfiguration(configFile);
    DefaultShellCallback callback = new DefaultShellCallback(isOverride);
    org.mybatis.generator.api.MyBatisGenerator myBatisGenerator = new org.mybatis.generator.api.MyBatisGenerator(config, callback, warnings);
    myBatisGenerator.generate(
        new ProgressCallback() {
          public void introspectionStarted(int i) {
            LOG.info("[dalgenx] introspectionStarted {}", i);
          }

          public void generationStarted(int i) {
              LOG.info("[dalgenx] generationStarted {}", i);
          }

          public void saveStarted(int i) {
            LOG.info("[dalgenx] saveStarted {}", i);
          }

          public void startTask(String s) {
            LOG.info("[dalgenx] startTask {}", s);
          }

          public void done() {
            LOG.info("[dalgenx] done\n");
          }

          public void checkCancel() {}
        });
  }
}
