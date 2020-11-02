unit Mat.Constants;

interface

const

    // Message and dialogs strings.
    ANALYSIS_PROGRESS_FINISHED = 'The analysis was finished succesfully';
    ANALYSIS_PROGRESS_ROOTFOLDERNOTSPECIFIED =
      'Please, specify root folder with project source code';
    ANALYSIS_PROJECTVERSION_NOTDETECTED = 'Not detected';
    COMPONENTS_DATABASE_MISSING_ERR = 'Components database is missing';

    // Routines.
    CRLF = #10#13;
    SHELL_OPEN_COMMAND = 'open';
    STRING_YES = 'Yes';
    STRING_NO = 'No';
    STANDART_VENDOR_NAME = '%Embarcadero%';

    // SQL.
    COMPONENTS_PARSE_FIELDS_SELECT_SQL = 'SELECT * FROM ComponentsDatabase ' +
      'WHERE flowertitle = ''';
    COMPONENTS_PARSE_FIELDS_INSERT_SQL = 'INSERT OR IGNORE INTO Uses SELECT *' +
      ' FROM ComponentsDatabase WHERE flowertitle = ''';
    INSERT_USES_SQL =
      'INSERT or ignore INTO Uses(ftitle, flowertitle ) VALUES (:ftitle, :flowertitle);';
    INSERT_PG_SQL =
      'INSERT or ignore INTO ProjectGroups(ftitle, fpath, fversion) VALUES (:ftitle, :fpath, :fversion);';
    INSERT_PJ_SQL =
      'INSERT or ignore INTO Projects(ftitle, fpath, fpgpath, fversion)' +
      ' VALUES (:ftitle, :fpath, :fpgpath, :fversion);';
    INSERT_UNITS_SQL = 'INSERT or ignore INTO Units(ftitle, fpath, ' +
      'fppath, flinescount, fformname ) VALUES ' +
      '(:ftitle, :fpath, :fppath, :flinescount,  :fformname);';
    SELECT_PG_COUNT = 'SELECT Count(*) from ProjectGroups';
    SELECT_PJ_COUNT = 'SELECT Count(*) from Projects';
    SELECT_UNITS_COUNT = 'SELECT Count(*) from Units';
    SELECT_ULINESCOUNT_COUNT = 'SELECT Sum(Units.flinescount) from Units';
    SELECT_PJVERSION = 'SELECT DISTINCT fversion from Projects';
    SHOW_PG_SQL =
      'SELECT ProjectGroups.rowno as "#", ProjectGroups.ftitle as "Project Group Name",'
      + '  ProjectGroups.fpath as "Path" ,  ProjectGroups.fversion as "Project version" '
      + '  FROM  ProjectGroups ORDER BY ';
    SHOW_PJ_SQL =
      'SELECT  Projects.rowno as "#", Projects.ftitle as "Project Name", ' +
      '  ProjectGroups.ftitle as "Project Group Name",' +
      '  Projects.fpath as "Path" , Count(Units.fpath) as "Units amount", ' +
      '  SUM(Units.fformname != "") as "Forms amount", Projects.fversion as "Project version" '
      + '  FROM Projects LEFT JOIN ProjectGroups  ON (Projects.fpgpath = ProjectGroups.fpath) '
      + '  LEFT JOIN Units  ON (Projects.fpath = Units.fppath) ' +
      '  GROUP BY Projects.fpath ORDER BY ';
    SHOW_U_SQL =
      'SELECT Units.rowno as "#", Projects.ftitle as "Project Name", ' +
      '  Units.ftitle as "Unit Name",' +
      '  Units.fpath as "Path" , Units.flinescount as "Lines" ' +
      '  FROM Units LEFT JOIN Projects  ON (Projects.fpath = Units.fppath) ORDER BY ';
    SHOW_C_SQL = 'SELECT  Uses.rowno as "#",' +
      ' ftitle as "Uses",  package as "Package", vendor as "Vendor", ' +
      'projecthomeurl as "Project home URL", licensename as "License name",  ' +
      'licensetype as "License type", classes as "Classes", platformssupport as "Platforms support", '
      + ' radstudioversionssupport as "RADStudio versions support", versionscompatibility as '
      + ' "Versions compatibility", analogues as "Analogues", comment as "Comment", '
      + ' convertto as "Convert to"  FROM Uses  ORDER BY ';
    INSERT_INTO_TABLE_SQL = ' (ftitle, flowertitle, package, vendor, ' +
      'projecthomeurl, licensename,  licensetype, classes, platformssupport, radstudioversionssupport, '
      + 'versionscompatibility, analogues, convertto, comment ) VALUES (:ftitle, :flowertitle, :package, :vendor, '
      + ':projecthomeurl, :licensename, :licensetype, :classes, :platformssupport, :radstudioversionssupport, '
      + ':versionscompatibility, :analogues, :convertto, :comment );';
    INSERT_INTO_TABLE_SQL_P = 'INSERT or ignore INTO ';
    CLEAR_PG_TABLE_SQL = 'DELETE FROM ProjectGroups;';
    CLEAR_PJ_TABLE_SQL = ('DELETE FROM Projects;');
    CLEAR_UNITS_TABLE_SQL = ('DELETE FROM Units;');
    CLEAR_USES_TABLE_SQL = ('DELETE FROM Uses;');
    CLEAR_TYPES_TABLE_SQL = ('DELETE FROM Types;');
    CLEAR_CD_TABLE_SQL = ('DELETE FROM ComponentsDatabase;');
    CREATE_TABLES_SQL =
      'CREATE TABLE IF NOT EXISTS ProjectGroups (rowno TEXT  NULL, ftitle TEXT  NULL,'
      + ' fpath TEXT  UNIQUE NULL PRIMARY KEY COLLATE NOCASE, fversion TEXT  NULL); '
      + 'CREATE TABLE IF NOT EXISTS Projects (rowno TEXT  NULL, ftitle TEXT  NULL,'
      + ' fpath TEXT  UNIQUE NULL PRIMARY KEY COLLATE NOCASE, fpgpath TEXT  NULL, fversion TEXT  NULL); '
      + ' CREATE TABLE IF NOT EXISTS Units (rowno TEXT  NULL, ftitle TEXT  NULL,'
      + ' fpath TEXT  UNIQUE NULL PRIMARY KEY COLLATE NOCASE, fppath TEXT  NULL,'
      + ' flinescount NUMERIC  NULL, fpointerscount NUMERIC  NULL, fformname TEXT  NULL); '
      + ' CREATE TABLE IF NOT EXISTS Uses (rowno TEXT  NULL, ftitle TEXT  NULL,'
      + ' flowertitle TEXT  UNIQUE NULL PRIMARY KEY COLLATE NOCASE, package TEXT  NULL,'
      + ' vendor TEXT  NULL, projecthomeurl TEXT  NULL, licensename TEXT  NULL,'
      + ' licensetype TEXT  NULL, classes TEXT  NULL, platformssupport TEXT  NULL, '
      + '  radstudioversionssupport TEXT  NULL, ' +
      ' versionscompatibility TEXT  NULL, analogues TEXT  NULL, comment TEXT  NULL, '
      + ' convertto TEXT  NULL); ' +
      ' CREATE TABLE IF NOT EXISTS ComponentsDatabase (rowno TEXT  NULL, ftitle TEXT  NULL,'
      + ' flowertitle TEXT  UNIQUE NULL PRIMARY KEY COLLATE NOCASE, package TEXT  NULL,'
      + ' vendor TEXT  NULL, projecthomeurl TEXT  NULL, licensename TEXT  NULL,'
      + ' licensetype TEXT  NULL, classes TEXT  NULL, platformssupport TEXT  NULL, '
      + '  radstudioversionssupport TEXT  NULL, ' +
      ' versionscompatibility TEXT  NULL, analogues TEXT  NULL, comment TEXT  NULL, '
      + ' convertto TEXT  NULL); ' +
      ' CREATE TABLE IF NOT EXISTS Types (rowno TEXT  NULL, ftitle TEXT  NULL,'
      + ' flowertitle TEXT  UNIQUE NULL PRIMARY KEY COLLATE NOCASE);';
    DETECT_STANDART_CLASSES_COUNT_SQL =
      'SELECT Count(*) FROM Uses WHERE vendor LIKE ''';

    // Database settings.
    SQL_DRIVER_NAME = 'SQLite';
    SQL_DATABASE_FILENAME = 'ParserDatabase.db';
    COMPONENTS_DATABASE_TABLE_NAME = 'ComponentsDatabase';

    // Fields.
    FTITLE_FIELD_NAME = 'ftitle';
    FLOWER_TITLE_FIELD_NAME = 'flowertitle';
    FPATH_FIELD_NAME = 'fpath';
    FVERSION_FIELD_NAME = 'fversion';
    FPGPATH_FIELD_NAME = 'fpgpath';
    FPPATH_FIELD_NAME = 'fppath';
    FLINESCOUNT_FIELD_NAME = 'flinescount';
    FFORMNAME_FIELD_NAME = 'fformname';
    FPACKAGE_FIELD_NAME = 'package';
    FVENDOR_FIELD_NAME = 'vendor';
    FPJ_HOME_URL_FIELD_NAME = 'projecthomeurl';
    FLICELCSE_NAME_FIELD_NAME = 'licensename';
    FLICELCSE_TYPE_FIELD_NAME = 'licensetype';
    FCLASSES_FIELD_NAME = 'classes';
    FPLATFORM_SUPPORT_NAME = 'platformssupport';
    FRADVERSION_SUPPORT_NAME = 'radstudioversionssupport';
    FVERSION_COMPATIBILITY_NAME = 'versionscompatibility';
    FANALOGUES_FIELD_NAME = 'analogues';
    FCONVERTTO_FIELD_NAME = 'convertto';
    FCOMMENT_FIELD_NAME = 'comment';
    FROW_NO_FIELD_NAME = '#';
    SUPPORTED_VERSIONS_FIELD_NAME = 'RADStudio versions support';
    FIELDS_LIST = 'ftitle, flowertitle, package, vendor, ' +
      'projecthomeurl, licensename,  licensetype, classes, platformssupport, radstudioversionssupport, '
      + 'versionscompatibility, analogues, convertto, comment ';
    FIELD_BORDER_WIDTH = 3;

    // Sort constants.
    SORT_ASC = 0;
    SORT_DESC = 1;
    SORT_DESC_STR = ' Desc ';
    SORT_ASC_STR = ' Asc ';
    DEFAULT_SORT = ' 1 Asc ';

    DELPHI_VERSIONS: TArray<String> = ['Unknown', 'Delphi 5', 'Delphi 7'];
    MAX_VERSION_WARNING = 20;

    // Colors.
    WARNING_COLOR = $004FD0F7;
    PROGRESS_COLOR = $204FD0F7;

    // Ini file settings.
    DATABASE_FOLDER = '\Database\';
    SETTINGS_FOLDER = '\Settings\';
    COLUMN_SECTION_NAME = 'column';
    FOLDER_SECTION_NAME = 'Folder';
    LAST_FOLDER_SECTION_NAME = 'lastfolder';

    // XML file.
    PG_NODE = 'PropertyGroup';
    PE_NODE = 'ProjectExtensions';
    BP_NODE = 'BorlandProject';
    PF_NODE = 'Platforms';
    PV_NODE = 'ProjectVersion';
    NODE_ATTR = 'value';
    WIN64_CONST = 'Win64';
    TRUE_VALUE = 'True';

    // Parser search strings.
    ASM_SEARCH_STRING = 'asm';
    USES_SEARCH_STRING = 'uses';
    TYPE_SEARCH_STRING = 'type';
    IMPLEMENTATION_SEARCH_STRING = 'implementation';
    PROGRAMM_SEARCH_STRING = 'program';
    LIBRARY_SEARCH_STRING = 'library';
    BDE_USES = 'DBTables';
    VERSION_CONST = 'version';

    // JSON file pairs.
    PACKAGE_JSON_PAIR = 'Package';
    VENDOR_JSON_PAIR = 'Vendor';
    PROJECTHOMEURL_JSON_PAIR = 'ProjectHomeUrl';
    LICENSENAME_JSON_PAIR = 'LicenseName';
    LICENSETYPE_JSON_PAIR = 'LicenseType';
    CLASSES_JSON_PAIR = 'Classes';
    PLATFORMSSUPPORT_JSON_PAIR = 'PlatformsSupport';
    RADSTUDIOVERSIONSSUPPORT_JSON_PAIR = 'RADStudioVersionsSupport';
    VERSIONSCOMPATIBILITY_JSON_PAIR = 'VersionsCompatibility';
    ANALOGUES_JSON_PAIR = 'Analogues';
    COMMENT_JSON_PAIR = 'Comment';
    CONVERTTO_JSON_PAIR = 'ConvertTo';

    // About.
    CONTRIBUTORS = 'Serge Pilko, Ruvim Tsevan, Sergey Khatskevich';

    // FileNames.
    SETTINGS_FILE_NAME = 'Settings.ini';
    JSON_FILE_NAME = 'ComponentsDatabase.json';
    NEW_FILE_FORMAT_ADDICT = 'oj';

    // Files extensions.
    PROJECT_GROUP_EXT_AST = '*.bpg';
    PROJECT_EXT_AST = '*.dpr';
    PROJECT_EXT = '.dpr';
    PAS_EXT = '.pas';
    PAS_EXT_AST = '*.pas';
    CSV_EXT = '.csv';
    CSV_FILTER = 'CSV (*.csv)|*.csv';

    // URLS.
    URL_EMBARCADERO_CUSTOMERPORTAL = 'https://my.embarcadero.com/#login';
    URL_EMBARCADERO_FIREDACMIGRATION =
      'http://docwiki.embarcadero.com/RADStudio/Sydney/en/BDE_Application_Migration_(FireDAC)';
    URL_EMBARCADERO_UNICODE =
      'http://docwiki.embarcadero.com/RADStudio/Sydney/en/Unicode_in_RAD_Studio';
    URL_LICENSE_APACHE20 = 'https://www.apache.org/licenses/LICENSE-2.0';

implementation

end.
