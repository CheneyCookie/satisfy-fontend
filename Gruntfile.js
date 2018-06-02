'use strict';

/*
检查js语法: npm install grunt-contrib-jshint --save-dev
合并文件: npm install grunt-contrib-concat --save-dev
压缩文件: npm install grunt-contrib-uglify --save-dev
监控文件: npm install grunt-contrib-watch --save-dev
删除文件: npm install grunt-contrib-clean --save-dev
复制文件: npm install grunt-contril-copy --save-dev
图像压缩: npm insatll grunt-contril-imagemin --save-dev
压缩合并CSS ： npm install grunt-contril-cssmin --save-dev
*/
module.exports = function(grunt) {
  // 配置项
  var AppConfig = {
    name: 'app',
    //源文件目录
    src: 'source',
    //生产文件目录
    dist: 'web'
  };

    // Project configuration.
  grunt.initConfig({
    config: AppConfig,

    pkg: grunt.file.readJSON('package.json'),
    uglify: {
      options: {
        banner: '/*! <%= pkg.author.name %>-<%=pkg.verson%> 最后修改于：<%= grunt.template.today("yyyy-mm-dd") %> */\n'
      },
      build: {
        options: {
          // 不混淆变量名
          mangle: false,
          // 不删除注释，还可以为 false（删除全部注释）
          preserveComments: 'false',
          // 输出压缩率，可选的值有 false(不输出信息)
          report: "min"
        },
        files: [{
          expand: true,
          cwd: '<%= config.dist %>/js',
          src: ['**/*.js'],
          dest: '<%= config.dist %>/js',
          ext: '.min.js'
        }]
      },
    },

    // 代码质量检查工具
    jshint: {
      files: ['Gruntfile.js', '<%= config.src %>/js/**/*.coffee'],
      options: {
        jshintrc: '.jshintrc'
      }
    },

    // concat: {
    //   options: {
    //       separator: ';',
    //       stripBanners: true
    //   },
    //   js: {
    //     src: [
    //       '<%= config.dist %>/js/*.js'
    //     ],
    //     dest: '<%= config.dist %>/js/app.js'
    //   },
    //   css:{
    //     src: [
    //       '<%= config.dist %>/style/*.css'
    //     ],
    //     dest: '<%= config.dist %>/style/main.css'
    //   }
    // },

    sass: {
      build: {
        files: [{
          expand: true,
          cwd: '<%= config.src %>/style',
          src: ['**/*.scss'],
          dest: '<%= config.dist %>/style',
          ext: '.css'
        }]
      }
    },

    coffee: {
      build: {
        files: [{
          expand: true,
          cwd: '<%= config.src %>',
          src: ['**/*.coffee'],
          dest: '<%= config.dist %>',
          ext: '.js'
        }]
      }
    },

    htmlmin:{
      build: {
        files: [{
          expand: true,
          cwd: '<%= config.src %>',
          src: ['**/*.html'],
          dest: '<%= config.dist %>',
          ext: '.html'
        }]
      }
    },

    cssmin: {
      options: {
        keepSpecialComments: 0
      },
      build: {
        files: [{
          expand: true,
          cwd: '<%= config.dist %>/style',
          src: ['**/*.css'],
          dest: '<%= config.dist %>/style',
          ext: '.css'
        }]
      }
    },

    // bower: {
    //   options: {
    //     targetDir: './web/lib',
    //     layout: 'byType',
    //     install: true,
    //     verbose: false,
    //     cleanTargetDir: false,
    //     cleanBowerDir: false,
    //     bowerOptions: {}
    //   },

    //   install: {
    //     //just run 'grunt bower:install' and you'll see files from your Bower packages in lib directory
    //   }
    // },

    watch: {
      sass: {
        files: ['<%= config.src %>/style/**/*.scss'],
        tasks: ['sass:build']
      },
      coffee: {
        files: ['<%= config.src %>/**/*.coffee'],
        tasks: ['coffee:build']
      },
      htmlmin: {
        files: ['<%= config.src %>/page/**/*.html'],
        tasks: ['htmlmin:build']
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-uglify');
  // grunt.loadNpmTasks('grunt-bower-task');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-htmlmin');
  grunt.loadNpmTasks('grunt-contrib-cssmin');

  // 默认被执行的任务列表。
  grunt.registerTask('default', ['sass', 'coffee', 'htmlmin', 'watch']);
};
