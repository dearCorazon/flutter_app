import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bean/CatalogBean.dart';
import 'package:flutter_app/Bean/ChoiceCard.dart';
import 'package:flutter_app/Bean/Judgement.dart';
import 'package:flutter_app/Bean/MutiChoiceBean.dart';
import 'package:flutter_app/Bean/Schedule.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_app/Log.dart';
class Sqlite_helper{
    static final _databasename= 'mydatabase';
    static final _databaseVersion =1;
    static final _sql_createTableUser="CREATE TABLE User(id INTEGER NOT NULL PRIMARY KEY ,email TEXT NOT NULL)";
    static final _sql_createTableTest='CREATE TABLE TEST(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,adderId INTEGER,question TEXT UNIQUE,chaos TEXT,answer TEXT,type INTEGER,catalogId INTEGER,tag INTEGER)';
    static final _sql_createTableCatalog='CREATE TABLE CATALOG(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,name TEXT,superiorId INTEGER)';
    static final _sql_createTableSchedule='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,testID INTEGER,userID INTEGER,status INTEGER,nextTime TEXT,followType INTEGER)';
    static final _sql_createTableCatalog2='CREATE TABLE CATALOG(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,name TEXT UNIQUE,superiorId INTEGER)';
    static final _sql_createTableSchedule2='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,testId INTEGER,userId INTEGER,status INTEGER,nextTime TEXT,followType INTEGER,ismark INTEGER,UNIQUE(testID,userID))';
    //static final _sql_createTableSchedule3='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,testID INTEGER,userID INTEGER,status INTEGER,nextTime TEXT,followType INTEGER,ismark INTEGER,UNIQUE(id,testID,userID))';
    static final _sql_createTableSchedule3='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,testId INTEGER,userId INTEGER,status INTEGER,nextTime TEXT,followType INTEGER,ismark INTEGER)';
    static final sql_table_ChoiceCard='create table choice(id integer not null primary key autoincrement,catalogId integer, star integer,catalogname text,number integer,faultnumber integer,answer text,chaos1 text,chaos2 text,chaos3 text,chaos4 text,question text)';
    static final sql_table_mutiCard='create table muti(id integer not null primary key autoincrement,catalogId integer, star integer,catalogname text,number integer,faultnumber integer,answer text,chaos1 text,chaos2 text,chaos3 text,chaos4 text,question text)';
    static final sql_table_judge='create table judge(id integer not null primary key autoincrement,catalogId integer, star integer,catalogname text,number integer,faultnumber integer,answer text,question text)';
    Sqlite_helper._privateConstructor();
    //static final sql_table_bank = 'CREATE TABLE bank(catalogId INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,catalogname TEXT UNIQUE)';
    static final Sqlite_helper instance = Sqlite_helper._privateConstructor(); 
    String tableTest ='test';
    String tableCatalog='catalog';
    String tableSchedule='schedule';
    Database _database;
  
    Future<Database> get database async{
      if(_database != null) return _database;
      _database = await _initDatabase();
      return _database;
    }
    _initDatabase()async{
      String _path;
      Directory documentaryDirectory = await getApplicationDocumentsDirectory();
      Logv.Logprint("数据库初始化........");
      print("logv:documentaryDiretory"+documentaryDirectory.toString());
      _path = join(documentaryDirectory.path,_databasename);
      print("logv:_path:"+_path);
      _database= await openDatabase(_path,version: _databaseVersion,
          onCreate: (Database db,int version)async{
            await Logv.Logprint("database onCreate:...........................");
            await Logv.Logprint("建表：");
            await db.execute(_sql_createTableCatalog2);
            await db.execute(_sql_createTableSchedule2);
            await db.execute(_sql_createTableTest);
            await db.execute(_sql_createTableUser);
            await db.execute(sql_table_ChoiceCard);
            await db.execute(sql_table_mutiCard);
            await db.execute(sql_table_judge);
            await Logv.Logprint("插入初始数据：");
            await db.insert(tableTest,Test.create("1+1=?", "2").toMap());//default 
            await db.insert(tableTest,Test.create("1+2=?", "3").toMap());//default 
            await db.insert(tableTest,Test.create("1+3=?", "4").toMap());//default 
            await db.insert(tableTest,Test.createWithCatalog("English", "英语",3).toMap());//TODO：一开始没有加await ，该语句执行，但后面的部分都没有执行，why？
            
            await db.insert(tableCatalog, Catalog.create("网络安全法考试(一)").toMap(),conflictAlgorithm: ConflictAlgorithm.ignore);
             await db.insert(tableCatalog, Catalog.create("网络安全法考试(二)").toMap(),conflictAlgorithm: ConflictAlgorithm.ignore);//id =1
            //await db.insert(tableCatalog, Catalog.create("网络安全法").toMap(),conflictAlgorithm: ConflictAlgorithm.ignore);//id =2 
           // await db.insert(tableCatalog, Catalog.create("English").toMap(),conflictAlgorithm: ConflictAlgorithm.ignore);//id =3
            //await db.insert('bank', CatalogBean('网络安全法考试(一)').toMap());
            await db.insert(tableSchedule,Schedule.create(1, 1).toMap());
            await db.insert(tableSchedule,Schedule.create(2, 1).toMap());
            await db.insert(tableSchedule,Schedule.create(3, 1).toMap());
            await db.insert(tableSchedule,Schedule.create(4, 1).toMap());
            //Logv.Logprint(schedule.toMap().toString());
           // print("schedule1:${schedule.toString()}");
//    await daoApi.insertChoicCard(ChoiceCard.creat("网络安全法规定，网络运营者应当制定________，及时处置系统漏洞、计算机病毒、网络攻击、网络侵入等安全风险", "网站安全规章制度 ", "网络安全事件应急预案      ", "网络安全事件补救措施 ", "网络安全事件应急演练方案  "));

            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            await sharedPreferences.setString('name', '未设置');
            await sharedPreferences.setString('email', '未登录');
            await sharedPreferences.setInt('userId', 1);
            await sharedPreferences.setBool('isLogin', false);
            await sharedPreferences.setInt("currentCatalogId", 1);
            await Logv.Logprint("用户信息初始化 userId为"+"${sharedPreferences.getInt("userId")}");
            
            //await db.insert(tableSchedule,Schedule.create(-1,1).toMap());
            //await db.insert(tableSchedule,Schedule.create(4,1).toMap());
            await db.insert('choice',ChoiceCardBean.creat('网络安全法规定，网络运营者应当制定________，及时处置系统漏洞、计算机病毒、网络攻击、网络侵入等安全风险', '网站安全规章制度', '网络安全事件应急预案', '网络安全事件补救措施', '网络安全事件应急演练方案','网站安全规章制度').toMap() );
            await db.insert('choice',ChoiceCardBean.creat(
              '国家支持网络运营者之间在网络安全信息____、 ____、 ____和________等方面进行合作， 提高网络运营者的安全保障能力。',
             '收集 分析 通报 应急处置',
              '发布 收集 分析 事故处理',
              '收集 分析 管理 应急处置', 
              '收集 分析 通报 应急处置',
               '审计 转发 处置 事故处理').toMap() );
          //  await db.insert('choice',ChoiceCardBean.creat(
          //     '国家支持网络运营者之间在网络安全信息____、 ____、 ____和________等方面进行合作， 提高网络运营者的安全保障能力。',

          //    '网站安全规章制度',
          //     '网络安全事件应急预案',
          //      '网络安全事件补救措施', 
               
          //      '网络安全事件应急演练方案').toMap() );
               await db.insert('choice',ChoiceCardBean.creat(
              '违反网络安全法第二十七条规定，从事危害网络安全的活动，或者提供专门用于从事危 害网络安全活动的程序、工具，或者为他人从事危害网络安全的活动提供技术支持、广告推 广、支付结算等帮助，尚不构成犯罪的，由公安机关没收违法所得，处_日以下拘留，可以 并处___以上___以下罚款。',
             '五日 五万元 五十万元',
              '三日 一万元 十万元',
               '五日 五万元 十万元', 
               '五日 五万元 五十万元 ',
               '十日 五万元 十万元').toMap() );
               await db.insert('choice',ChoiceCardBean.creat(
              '互联网出口必须向公司信息化主管部门进行____后方可使用。 ',
             '备案审批',
             '备案审批',
              '申请 ',
               '说明 ', 
               '报备').toMap() );
               await db.insert('choice',ChoiceCardBean.creat(
              '关于信息内网网络边界安全防护说法不准确的一项是____。 ',
             '纵向边界的网络访问可以不进行控制',

              '要按照公司总体防护方案要求进行',
               '应加强信息内网网络横向边界的安全防护', 
               '纵向边界的网络访问可以不进行控制',
               
               '应加强信息内网网络横向边界的安全防护').toMap() );

            await db.insert('muti', MutiChoiceBean.creat(
              "建设关键信息基础设施应当确保其具有支持业务稳定、持续运行的性能，并保证安全技术 措施________", 
              "ABD", 
              "同步规划", 
              "同步建设",
              "同步投运 ",
              "同步使用 ").toMap());
               await db.insert('muti', MutiChoiceBean.creat(
              "电力二次系统安全防护策略包括________", 
              "ABCD",
              "安全分区", 
              "网络专用 ", 
              "横向隔离  ",
              "纵向认证 ",
              ).toMap());
               await db.insert('muti', MutiChoiceBean.creat(
              "公司秘密包括________两类", 
              "AC", 
              "商业秘密", 
              "个人秘密",
              "工作秘密",
              "部门文件").toMap());
               await db.insert('muti', MutiChoiceBean.creat(
              "国家采取措施，____来源于中华人民共和国境内外的网络安全风险和威胁，保护关键信息 基础设施免受攻击、侵入、干扰和破坏。 ", 
              "ABC", 
              "监测", 
              "防御 ",
              "处置 ",
              "隔离 ").toMap());
               await db.insert('muti', MutiChoiceBean.creat(
              "信息安全“三个不发生”是指________", 
              "ABC", 
              "确保不发生大面积信息系统故障停运事故", 
              "确保不发生恶性信息泄密事故",
              "确保不发生信息外网网站被恶意篡改事故 ",
              "确保不发生信息内网非法外联事故 ").toMap());
               await db.insert('muti', MutiChoiceBean.creat(
              "下列情况违反“五禁止”的有________", 
              "ABCD", 
              "在信息内网计算机上存储国家秘密信息", 
              "在信息外网计算机上存储企业秘密信息",
              "在信息内网和信息外网计算机上交叉使用普通优盘",
              "在信息内网和信息外网计算机上交叉使用普通扫描仪 ").toMap());
               await db.insert('muti', MutiChoiceBean.creat(
              "网络运营者收集、 使用个人信息， 应当遵循______________的原则， 公开收集、 使用规则， 明示收集、使用信息的目的、方式和范围，并经被收集者同意。", 
              "BCD", 
              "真实 ", 
              "合法 ",
              "正当 ",
              "必要  ").toMap());
               await db.insert('muti', MutiChoiceBean.creat(
              "下列关于网络信息安全说法正确的有_______。", 
              "AC", 
              "网络运营者应当对其收集的用户信息严格保密", 
              "网络运营者应妥善管理用户信息，无需建立用户信息保护制度",
              "网络运营者不得泄露、篡改、毁损其收集的个人信息",
              "在经过处理无法识别特定个人且不能复原的情况下，未经被收集者同意，网络运营者不 得向他人提供个人信息。 ").toMap());
              
               await db.insert('muti', MutiChoiceBean.creat(
              "下列关于内外网邮件系统说法正确的有________。", 
              "ABCD", 
              "严禁使用未进行内容审计的信息内外网邮件系统", 
              "严禁用户使用默认口令作为邮箱密码",
              "严禁内外网邮件系统开启自动转发功能",
              "严禁用户使用互联网邮箱处理公司办公业务  ").toMap());

               await db.insert('muti', MutiChoiceBean.creat(
              "网络运营者，是指________。", 
              "BCD", 
              "网络运维者", 
              "网络所有者 ",
              "网络服务提供者 ",
              "网络管理者  ").toMap());


                await db.insert('muti', MutiChoiceBean.creat(
              "下列关于网络安全法的说法错误的有________", 
              "AB", 
              "国家规定关键信息基础设施以外的网络运营者必须参与关键信息基础设施保护体系。", 
              "关键信息基础设施的运营者可自行采购网络产品和服务不通过安全审查 ",
              "网络运营者应当加强对其用户发布的信息的管理，发现法律、行政法规禁止发布或者传 输的信息的，应当立即向上级汇报。 ",
              "国家网信部门应当统筹协调有关部门加强网络安全信息收集、分析和通报工作，按照规 定统一发布网络安全监测预警信息。  ").toMap());
              
                await db.insert('muti', MutiChoiceBean.creat(
              "某单位信息内网的一台计算机上一份重要文件泄密，但从该计算机上无法获得泄密细节 和线索，可能的原因是________。 ", 
              "ABCD", 
              "该计算机未开启审计功能    ",
              "该计算机审计日志未安排专人进行维护 ",
              "该计算机感染了木马", 
              "该计算机存在系统漏洞 ").toMap());
                await db.insert('muti', MutiChoiceBean.creat(
              "网络安全事件发生的风险增大时，省级以上人民政府有关部门应当按照规定的权限和程 序，并根据网络安全风险的特点和可能造成的危害，采取下列措施_______。", 
              "ABCD", 
              "要求有关部门、机构和人员及时收集、报告有关信息", 
              "加强对网络安全风险的监测 ",
              "组织有关部门、机构和专业人员，对网络安全风险信息进行分析评估  ",
              "向社会发布网络安全风险预警，发布避免、减轻危害的措施 ").toMap());
                await db.insert('muti', MutiChoiceBean.creat(
              "因网络安全事件，发生突发事件或者生产安全事故的，应当依照_______等有关法律、行 政法规的规定处置。", 
              "BC", 
              "《中华人民共和国网络安全法》", 
              "《中华人民共和国突发事件应对法》 ",
              "《中华人民共和国安全生产法》 ",
              "《中华人民共和国应急法》 ").toMap());

               await db.insert('muti', MutiChoiceBean.creat(
              "网络安全事件应急预案应当按照事件发生后的________、________等因素对网络安全事 件进行分级。。", 
              "AB", 
              "危害程度", 
              "影响范围",
              "事件等级",
              "关注程度").toMap());

             await db.insert('judge', JudgementBean.create(
               '国务院电信主管部门负责统筹协调网络安全工作和相关监督管理工作',
                'false')
                .toMap());

            await db.insert('judge', JudgementBean.create(
               '任何个人和组织有权对危害网络安全的行为向网信、电信、公安等部门举报',
                'true')
                .toMap());
            
            await db.insert('judge', JudgementBean.create(
               '收到举报的部门但不属于本部门职责的，应及时向上级汇报。',
                'true')
                .toMap());

                await db.insert('judge', JudgementBean.create(
               '任何个人和组织有权对危害网络安全的行为向网信、电信、公安等部门举报',
                'true')
                .toMap());

                await db.insert('judge', JudgementBean.create(
               '收到举报的部门但不属于本部门职责的，应及时向上级汇报。',
                'true')
                .toMap());

                await db.insert('judge', JudgementBean.create(
               '国家不支持企业、研究机构、高等学校、网络相关行业 组织参与网络安全国家标准、行 业标准的制定。',
                'false')
                .toMap());
                await db.insert('judge', JudgementBean.create(
               '对关键业务系统的数据，每年应至少进行一次备份数据的恢复演练',
                'false')
                .toMap());
                await db.insert('judge', JudgementBean.create(
               '任何个人和组织有权对危害网络安全的行为向网信、电信、公安等部门举报',
                'true')
                .toMap());
                await db.insert('judge', JudgementBean.create(
               '网络运营者不得收集与其提供的服务无关的个人信息',
                'true')
                .toMap());
                await db.insert('judge', JudgementBean.create(
               '信息系统应急预案既要制定、修订和完善，更需要演练与处理。',
                'true')
                .toMap());
               await db.insert('judge', JudgementBean.create(
               '外部合作单位人员进行开发、测试工作要先与公司签署保密协议。',
                'true')
                .toMap());
                await db.insert('judge', JudgementBean.create(
               '信息系统应急预案既要制定、修订和完善，更需要演练与处理。',
                'true')
                .toMap());

                await db.insert('judge', JudgementBean.create(
               '网络产品、服务的提供者应当为其产品、服务持续提供安全维护；但出现特殊情况时， 在规定或者当事人约定的期限内，可以视情况终止提供安全维护。网络产品、服务的提供者应当为其产品、服务持续提供安全维护；但出现特殊情况时， 在规定或者当事人约定的期限内，可以视情况终止提供安全维护。',
                'false')
                .toMap());
               
              



            _import2()async{
              ////单选
            
      
              await db.insert('choice',ChoiceCardBean.create2(
              '网络产品、服务具有收集用户信息功能的，其提供者应当       。',
              '向用户明示并取得同意',
              '向用户明示但不需要同意',
              '向用户明示并取得同意', 
              '不需要向用户明示但需要取得同意',
              '不需要向用户明示也不需要取得同意').toMap() );
              await db.insert('choice',ChoiceCardBean.create2(
              '网络运营者不得      、      、      其收集的个人信息。',
              '泄露、篡改、毁损',
              '泄露、篡改、出售',
              '泄露、篡改、毁损', 
              '泄露、删除、毁损',
              '泄露、删除、出售').toMap() );
              await db.insert('choice',ChoiceCardBean.create2(
              '国家       负责统筹协调网络安全工作和相关监督管理工作。国务院       、       和其他有关机关依照本法和有关法律、行政法规的规定，在各自职责范围内负责网络安全保护和监督管理工作。',
              '各级人民政府，网信部门，电信主管部门',
              '网信部门，电信主管部门，公安部门',
              '电信主管部门，网信部门，公安部门', 
              '公安部门，电信主管部门，网信部门',
              '各级人民政府，网信部门，电信主管部门').toMap() );
              await db.insert('choice',ChoiceCardBean.create2(
              '       及其有关部门应当组织开展经常性的网络安全宣传教育，并指导、督促有关单位做好网络安全宣传教育工作。',
              '各级人民政府',
              '各级人民政府',
              '各级人民政府', 
              '各级检察机关',
              '各级新闻机构').toMap() );
              await db.insert('choice',ChoiceCardBean.create2(
              '       应当制定网络安全事件应急预案，及时处置系统漏洞、计算机病毒、网络攻击、网络侵入等安全风险；在发生危害网络安全的事件时，立即启动应急预案，采取相应的补救措施，并按照规定向有关主管部门报告。',
              '网络运营者',
              '网络使用者',
              '网络管理者', 
              '网络运营者',
              '网络监控者').toMap() );
              await db.insert('choice',ChoiceCardBean.create2(
              '网络运营者应当为       、国家安全机关依法维护国家安全和侦察犯罪的活动提供技术支持和协助。',
              '公安机关',
              '检察院',
              '公安机关', 
              '网信部门',
              '工信部门').toMap() );
              await db.insert('choice',ChoiceCardBean.create2(
              '根据网络安全法的相关规定，以下说法错误的是      。',
              '国家推进网络安全社会化服务体系建设，只能由国家机构开展网络安全认证、检测和风险评估等安全服务。',
              '国家鼓励开发网络数据安全保护和利用技术，促进公共数据资源开放，推动技术创新和经济社会发展。',
              '国家支持企业和高等学校、职业学校等教育培训机构开展网络安全相关教育与培训，采取多种方式培养网络安全人才，促进网络安全人才交流。', 
              '国家推进网络安全社会化服务体系建设，只能由国家机构开展网络安全认证、检测和风险评估等安全服务。',
              '国家实施网络可信身份战略，支持研究开发安全、方便的电子身份认证技术，推动不同电子身份认证之间的互认。').toMap() );
              await db.insert('choice',ChoiceCardBean.create2(
              '______建立网络安全监测预警和信息通报制度。',
              '国家',
              '国家',
              '国家网信部门', 
              '网络运营者',
              '个人').toMap() );
              await db.insert('choice',ChoiceCardBean.create2(
              '网络运营者应当采取      措施和其他      措施，确保其收集的个人信息安全，防止信息泄露、毁损、丢失。',
              '技术 必要',
              '管理 必要',
              '技术 必要', 
              '管理 合理',
              '技术 合理').toMap() );
              await db.insert('choice',ChoiceCardBean.create2(
              '网络运营者应当加强对其用户发布的信息的管理，发现法律、行政法规禁止发布或者传输的信息的，应当立即停止      该信息，采取      等处置措施，防止信息      ，      有关记录，并向有关主管部门报告。',
              '传输 消除 扩散 保存',
              '传播 消除 扩散 保存',
              '传播 删除 扩散 保留', 
              '传输 消除 扩散 保存',
              '传输 消除 扩散 保存').toMap() );
              await db.insert('choice',ChoiceCardBean.create2(
              '网络运营者为用户办理网络接入等入网手续时，未要求用户提供真实身份信息，或者对不提供真实身份信息的用户提供相关服务的，由有关主管部门责令改正；拒不改正或者情节严重的，处      罚款，并可以由有关主管部门责令暂停相关业务、停业整顿、关闭网站、吊销相关业务许可证或者吊销营业执照，对直接负责的主管人员和其他直接责任人员处      罚款。',
              '五万元以上五十万元以下，一万元以上十万元以下',
              '一万元以上十万元以下，五千元以上五万元以下',
              '一万元以上十万元以下，一万元以上五万元以下', 
              '五万元以上五十万元以下，五千元以上五万元以下',
              '五万元以上五十万元以下，一万元以上十万元以下').toMap() );
              await db.insert('choice',ChoiceCardBean.create2(
              '从事危害网络安全的活动，或者提供专门用于从事危害网络安全活动的程序、工具，或者为他人从事危害网络安全的活动提供技术支持、广告推广、支付结算等帮助，尚不构成犯罪的，由公安机关没收违法所得，处      拘留，可以并处五万元以上五十万元以下罚款；情节较重的，处      拘留，可以并处十万元以上一百万元以下罚款。',
              '五日以下，五日以上十五日以下',
              '五日以下，五日以上十五日以下',
              '十日以下，十日以上十五日以下', 
              '五日以下，五日以上十日以下',
              '十日以下，十日以上十五日以下').toMap() );
              
              await db.insert('choice',ChoiceCardBean.create2(
              '____和有关部门违反《中华人民共和国网络安全法》，将在履行网络安全保护职责中获取的信息用于其他用途的，对直接负责的主管人员和其他直接责任人员依法给予处分。',
              '网信部门',
              '公安机关',
              '网信部门', 
              '工信部门',
              '检察院').toMap() );
              await db.insert('choice',ChoiceCardBean.create2(
              '违反《中华人民共和国网络安全法》规定，给他人造成损害的，依法承担      。',
              '民事责任',
              '刑事责任',
              '行政责任', 
              '民事责任',
              '行政责任').toMap() );
              await db.insert('choice',ChoiceCardBean.create2(
              '违反《中华人民共和国网络安全法》规定，构成违反治安管理行为的，依法给予治安管理处罚；构成犯罪的，依法追究      。',
              '刑事责任',
              '刑事责任',
              '行政责任', 
              '民事责任',
              '民事责任').toMap() );

              //多选
                 await db.insert('muti', MutiChoiceBean.creat2(
              "在中华人民共和国境内       网络，以及网络安全的监督管理，适用网络安全法。", 
              "ABCD", 
              "建设", 
              "运营",
              "维护",
              "使用").toMap());
                await db.insert('muti', MutiChoiceBean.creat2(
              "任何个人和组织使用网络应当遵守宪法法律，遵守公共秩序，尊重社会公德，不得危害网络安全，不得利用网络从事       ", 
              "ABCD", 
              "危害国家安全、荣誉和利益，煽动颠覆国家政权、推翻社会主义制度", 
              "煽动分裂国家、破坏国家统一，宣扬恐怖主义、极端主义，宣扬民族仇恨、民族歧视",
              "传播暴力、淫秽色情信息，编造、传播虚假信息扰乱经济秩序和社会秩序",
              "侵害他人名誉、隐私、知识产权和其他合法权益").toMap());
                await db.insert('muti', MutiChoiceBean.creat2(
              "网络运营者应当按照网络安全等级保护制度的要求，保障网络免受干扰、破坏或者未经授权的访问，防止网络数据泄露或者被窃取、篡改。以下哪些属于需履行的安全保护义务       。", 
              "ABCD", 
              "制定内部安全管理制度和操作规程，确定网络安全负责人，落实网络安全保护责任", 
              "采取防范计算机病毒和网络攻击、网络侵入等危害网络安全行为的技术措施",
              " 采取监测、记录网络运行状态、网络安全事件的技术措施，并按照规定留存相关的网络日志不少于六个月",
              "采取数据分类、重要数据备份和加密等措施  ").toMap());
                await db.insert('muti', MutiChoiceBean.creat2(
              "网络运营者收集、使用个人信息，应当遵循      、      和      的原则", 
              "BCD", 
              "公开", 
              "合法",
              "正当　 ",
              " 必要").toMap());
                await db.insert('muti', MutiChoiceBean.creat2(
              'ABCD',
              "网络，是指由计算机或者其他信息终端及相关设备组成的按照一定的规则和程序对信息进行       的系统。", 
              "收集", 
              "存储  ", 
              "传输  ",
              "交换  ",
              ).toMap());

              await db.insert('muti', MutiChoiceBean.creat2(
              "个人信息，是指以电子或者其他方式记录的能够单独或者与其他信息结合识别自然人个人身份的各种信息，包括但不限于自然人的       等。", 
              "ABCD", 
              "姓名   ", 
              "出生日期  ",
              "身份证件号码   ",
              "个人生物识别信息").toMap());

              await db.insert('muti', MutiChoiceBean.creat2(
              "网络安全，是指通过采取必要措施，防范对网络的       ，使网络处于稳定可靠运行的状态，以及保障网络数据的完整性、保密性、可用性的能力。", 
              "ABCD", 
              "攻击 ", 
              "侵入     ",
              "干扰     ",
              "破坏     ").toMap());





              //判断
                await db.insert('judge', JudgementBean.create2(
               '《中华人民共和国网络安全法》自2017年6月1日起施行。',
                'true')
                .toMap());
                      await db.insert('judge', JudgementBean.create2(
               '网络运营者为用户办理网络接入、域名注册服务，办理固定电话、移动电话等入网手续，或者为用户提供信息发布、即时通讯等服务，在与用户签订协议或者确认提供服务时，可视情况决定用户是否需要提供真实身份信息。',
                'false')
                .toMap());
              await db.insert('judge', JudgementBean.create2(
               '网络运营者开展经营和服务活动，必须遵守法律、行政法规，尊重社会公德，遵守商业道德，诚实信用，履行网络安全保护义务，接受政府和社会的监督，承担社会责任。',
                'true')
                .toMap());
                      await db.insert('judge', JudgementBean.create2(
               '国家支持研究开发有利于未成年人健康成长的网络产品和服务，依法惩治利用网络从事危害未成年人身心健康的活动，为未成年人提供安全、健康的网络环境',
                'true')
                .toMap());
                      await db.insert('judge', JudgementBean.create2(
               '任何个人和组织有权对危害网络安全的行为向网信、电信、公安等部门举报。',
                'true')
                .toMap());
                      await db.insert('judge', JudgementBean.create2(
               '网络产品、服务的提供者应当为其产品、服务持续提供安全维护；在规定或者当事人约定的期限内，可以视情况终止提供安全维护。',
                'false')
                .toMap());
                      await db.insert('judge', JudgementBean.create2(
               '国家支持网络运营者之间在网络安全信息收集、分析、通报和应急处置等方面进行合作，提高网络运营者的安全保障能力。',
                'true')
                .toMap());
                      await db.insert('judge', JudgementBean.create2(
               '网信部门和有关部门在履行网络安全保护职责中获取的信息，除用于维护网络安全的需要外，还可用于其他用途。',
                'false')
                .toMap());
                      await db.insert('judge', JudgementBean.create2(
               '信息基础设施的运营者采购网络产品和服务，可能影响国家安全的，应当通过国家网信部门的安全审查。',
                'false')
                .toMap());
                      await db.insert('judge', JudgementBean.create2(
               '网络运营者应当对其收集的用户信息严格保密，并建立健全用户信息保护制度。',
                'true')
                .toMap());
                      await db.insert('judge', JudgementBean.create2(
               '未经被收集者同意，网络运营者不得向他人提供个人信息；包括，经过处理无法识别特定个人且不能复原的信息。',
                'false')
                .toMap());
                      await db.insert('judge', JudgementBean.create2(
               '任何个人和组织不得窃取或者以其他非法方式获取个人信息，不得非法出售或者非法向他人提供个人信息。',
                'true')
                .toMap());
                      await db.insert('judge', JudgementBean.create2(
               '任何个人和组织发送的电子信息、提供的应用软件，不得设置恶意程序，不得含有法律、行政法规禁止发布或者传输的信息。',
                'true')
                .toMap());
                      await db.insert('judge', JudgementBean.create2(
               '有《中华人民共和国网络安全法》规定的违法行为的，依照有关法律、行政法规的规定记入信用档案，并予以公示。',
                'true')
                .toMap());
                      await db.insert('judge', JudgementBean.create2(
               '违反《中华人民共和国网络安全法》规定的，受到刑事处罚的人员，终身不得从事网络安全管理和网络运营关键岗位的工作。',
                'true')
                .toMap());


            }
            //    await db.insert('choice',ChoiceCard.creat(
            //   '国家支持网络运营者之间在网络安全信息____、 ____、 ____和________等方面进行合作， 提高网络运营者的安全保障能力。',
            //  '网站安全规章制度',
            //   '网络安全事件应急预案',
            //    '网络安全事件补救措施', 
               
            //    '网络安全事件应急演练方案').toMap() );await db.insert('choice',ChoiceCard.creat(
            //   '国家支持网络运营者之间在网络安全信息____、 ____、 ____和________等方面进行合作， 提高网络运营者的安全保障能力。',
            //  '网站安全规章制度',
            //   '网络安全事件应急预案',
            //    '网络安全事件补救措施', 
               
            //    '网络安全事件应急演练方案').toMap() );
            //    await db.insert('choice',ChoiceCard.creat(
            //   '国家支持网络运营者之间在网络安全信息____、 ____、 ____和________等方面进行合作， 提高网络运营者的安全保障能力。',
            //  '网站安全规章制度',
            //   '网络安全事件应急预案',
            //    '网络安全事件补救措施', 
               
            //    '网络安全事件应急演练方案').toMap() );
            await _import2();
            //await db.insert(tableSchedule,schedule.toMap());
      } );
      var version =await _database.getVersion();
      Logv.Logprint("DB version:"+version.toString());
      return _database;
    }
    Future<void> close()async{
      _database.close();
    }
}