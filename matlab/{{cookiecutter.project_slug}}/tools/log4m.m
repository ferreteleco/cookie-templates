classdef log4m < handle
    %LOG4M This is a simple logger based on the idea of the popular log4j.
    %
    % Description: Log4m is designed to be relatively fast and very easy to
    % use. It has been designed to work well in a matlab environment.
    % Please contact me (info below) with any questions or suggestions!
    %
    %
    % Author:
    %       Luke Winslow <lawinslow@gmail.com>
    % Heavily modified version of 'log4matlab' which can be found here:
    %       http://www.mathworks.com/matlabcentral/fileexchange/33532-log4matlab
    %

    properties (Constant)
        ALL = 0;
        TRACE = 1;
        DEBUG = 2;
        INFO = 3;
        WARN = 4;
        TIMING = 5;
        ERROR = 6;
        FATAL = 7;
        OFF = 8;
    end

    properties(Access = protected)
        logger;
        lFile;
    end

    properties(SetAccess = protected)
        fullpath = '';
        commandWindowLevel = log4m.ALL;
        logLevel = log4m.INFO;
    end

    methods (Static)

        function obj = getLogger( logPath )
            %GETLOGGER Returns instance unique logger object.
            %   PARAMS:
            %       logPath - Relative or absolute path to desired logfile.
            %   OUTPUT:
            %       obj - Reference to signular logger object.
            %

            if(nargin == 0)
                logPath = '';
            elseif(nargin > 1)
                error("Logger:tooManyInputs", 'getLogger only accepts one parameter input');
            end

            if ~strcmp(logPath, '')
                base_log_dir = fileparts(logPath);

                if isfolder(base_log_dir) == 0 && ~strcmp(base_log_dir, "")
                    mkdir(base_log_dir)
                end

            end
            persistent localObj;
            if isempty(localObj) || ~isvalid(localObj)
                if ~strcmp(logPath, '')
                    localObj = log4m(logPath);
                else
                    localObj = log4m();
                end
            end
            obj = localObj;
        end

        function testSpeed( logPath )
            %TESTSPEED Gives a brief idea of the time required to log.
            %
            %   Description: One major concern with logging is the
            %   performance hit an application takes when heavy logging is
            %   introduced. This function does a quick speed test to give
            %   the user an idea of how various types of logging will
            %   perform on their system.
            %

            L = log4m.getLogger(logPath);


            L.setCommandWindowLevel(L.TRACE);
            L.setLogLevel(L.OFF);
            tic;
            for i=1:1e5
                L.trace('log4mTest','test');
            end

            disp('1e5 logs when logging only to command window');
            toc;

            disp('1e5 logs when logging is off');

            L.setCommandWindowLevel(L.OFF);
            L.setLogLevel(L.OFF);
            tic;
            for i=1:1e5
                L.trace('log4mTest','test');
            end
            toc;

            disp('1e5 logs when logging to file');

            L.setCommandWindowLevel(L.OFF);
            L.setLogLevel(L.TRACE);
            tic;
            for i=1:1e5
                L.trace('log4mTest','test');
            end
            toc;
        end

    end

    methods

        function setFilename(self,logPath)
            %SETFILENAME Change the location of the text log file.
            %
            %   PARAMETERS:
            %       logPath - Name or full path of desired logfile
            %

            [fid,message] = fopen(logPath, 'a');

            if fid < 0
                error("Logger:badFile", "Problem with supplied logfile path: %s", message);
            end
            fclose(fid);
            self.fullpath = logPath;

        end


        function setCommandWindowLevel(self,loggerIdentifier)
            self.commandWindowLevel = loggerIdentifier;
        end


        function setLogLevel(self,logLevel)
            self.logLevel = logLevel;
        end

        function trace(self, funcName, message)
            %TRACE Log a message with the TRACE level
            %
            %   PARAMETERS:
            %       funcName - Name of the function or location from which
            %       message is coming.
            %       message - Text of message to log.
            %
            self.writeLog(self.TRACE,funcName,message);
        end

        function debug(self, funcName, message)
            %TRACE Log a message with the DEBUG level
            %
            %   PARAMETERS:
            %       funcName - Name of the function or location from which
            %       message is coming.
            %       message - Text of message to log.
            %
            self.writeLog(self.DEBUG,funcName,message);
        end


        function info(self, funcName, message)
            %TRACE Log a message with the INFO level
            %
            %   PARAMETERS:
            %       funcName - Name of the function or location from which
            %       message is coming.
            %       message - Text of message to log.
            %
            self.writeLog(self.INFO,funcName,message);
        end


        function warn(self, funcName, message)
            %TRACE Log a message with the WARN level
            %
            %   PARAMETERS:
            %       funcName - Name of the function or location from which
            %       message is coming.
            %       message - Text of message to log.
            %
            self.writeLog(self.WARN,funcName,message);
        end


        function error(self, funcName, message)
            %TRACE Log a message with the ERROR level
            %
            %   PARAMETERS:
            %       funcName - Name of the function or location from which
            %       message is coming.
            %       message - Text of message to log.
            %
            self.writeLog(self.ERROR,funcName,message);
        end


        function fatal(self, funcName, message)
            %TRACE Log a message with the FATAL level
            %
            %   PARAMETERS:
            %       funcName - Name of the function or location from which
            %       message is coming.
            %       message - Text of message to log.
            %
            self.writeLog(self.FATAL,funcName,message);
        end

        function timing(self, funcName, message)
            %TRACE Log a message with the TIMING level
            %
            %   PARAMETERS:
            %       funcName - Name of the function or location from which
            %       message is coming.
            %       message - Text of message to log.
            %
            self.writeLog(self.TIMING, funcName, message);
        end
    end

    % Private Methods %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods (Access = private)

        function self = log4m(fullpath_passed)

            if nargin > 0
                path = fullpath_passed;
                self.setFilename(path);
            end

        end

        function levelStr = getLevelStr(self, level)
            switch level
            case {self.TRACE}
                    levelStr = 'TRACE';
            case {self.DEBUG}
                    levelStr = 'DEBUG';
            case {self.INFO}
                    levelStr = 'INFO';
            case {self.WARN}
                    levelStr = 'WARN';
            case {self.ERROR}
                    levelStr = 'ERROR';
            case {self.FATAL}
                    levelStr = 'FATAL';
        case {self.TIMING}
            levelStr = 'TIMING';
                otherwise
                    levelStr = 'UNKNOWN';
            end
        end

        function writeLog(self, level, scriptName, message)

            levelStr = self.getLevelStr(level);
            logstr = sprintf('%s %s %s -> %s' ...
                , datestr(now, 'yyyy-mm-dd HH:MM:SS,FFF') ...
                , levelStr ...
                , scriptName ... % Have left this one with the '.' if it is passed
                , message);

            % If necessary write to command window
            if (self.commandWindowLevel <= level)
                fprintf('%s', logstr);
            end

            %df currently set log level is too high, just skip this log
            if (self.logLevel > level)
                return;
            end

            if ~strcmp(self.fullpath, '')
                % Append new log to log file
                try
                    fid = fopen(self.fullpath, 'a');
                    fprintf(fid, '%s', logstr);
                    fclose(fid);
                catch ME_1
                    dispd(ME_1);
                end

            end
        end
    end
end

