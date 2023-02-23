classdef Buffer < BaseClass
    %BUFFER Acts as a input buffer for a number of blocks of size M, and serves them one by
    % one.
    %
    %   Attributes:
    %
    %     - information_block_size: Size of the information block that will be consumed from the
    %       buffer.
    %
    %     - internal_buffer: This buffer holds the input that will be consumed block by block.
    %
    %     - consumed_counter: Internal counter for the number of blocks that have been consumed.
    %
    %     - N_full_blocks: Number of blocks stored currently in the internal buffer.
    %
    % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
    %
    % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
    % Copyright (c) 2022 Andrés Ferreiro González

    properties (SetAccess = private)
        information_block_size;
        internal_buffer = [];
        consumed_counter = 0;
        N_full_blocks = 0;
    end

    methods

        function obj = Buffer(information_block_size, NameValArgs)
            %BUFFER Constructs an instance of this class.
            %
            %   Input Arguments:
            %
            %     - information_block_size: Size of the information block that will be consumed
            %       from the buffer.
            %
            %   Tuple Arguments:
            %
            %     - dumpFilesPath: relative or absolute path location where to store the result of
            %       the buffer compsumption operations. Note that 'input_data_block_', its number
            %       within the buffer, its identifier, the execution date and the data format
            %       are inserted in the generated filenames in order to differentiate between
            %       continuous executions. If a void path ("") is specified, data dumping is
            %       disabled.
            %
            %     - componentIdentifier: String identifying the component (useful when using more
            %       than one instance of the same component in the same execution). Defaults to a
            %       random set of letters (A-Z, size 5).
            %
            % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
            %
            % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
            % Copyright (c) 2022 Andrés Ferreiro González

            arguments
                information_block_size (1, 1) {mustBeInteger, mustBePositive}
                NameValArgs.dumpFilesPath (1, 1) string = ""
                NameValArgs.componentIdentifier (1, 1) string = "Buffer"
                NameValArgs.SAVE_FORMAT (1, 1) string = "double"
            end

            obj@BaseClass(NameValArgs.componentIdentifier, ...
                NameValArgs.dumpFilesPath, NameValArgs.SAVE_FORMAT);

            obj.LOG.info(mfilename, ...
                sprintf("Initializing Buffer object (%s)", obj.component_identifier));

            obj.information_block_size = information_block_size;

            obj.LOG.debug(mfilename, ...
                sprintf("Buffer object (%s) successfully initialized", ...
                obj.component_identifier));
        end

        function insert_elements(obj, input_elements)
            %INSERT_ELEMENTS Inserts information that does not match being multiple of the size of
            % an information block.
            %
            %   It is assumed that eventually the rest of the information block will be filled in
            %   and the only issue is that it has not been fully generated yet.
            %
            %
            %   Input arguments:
            %
            %     - input_elements: Elements to append to the internal buffer.
            %
            % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
            %
            % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
            % Copyright (c) 2022 Andrés Ferreiro González

            arguments
                obj (1, 1) Buffer
                input_elements (:, 1)
            end

            obj.LOG.debug(mfilename, ...
                sprintf("Inserting a total of (%d) single elements in the internal buffer", ...
                length(input_elements)));

            obj.internal_buffer = [obj.internal_buffer; input_elements];
            obj.N_full_blocks = floor( ...
                length(obj.internal_buffer) / obj.information_block_size);

            obj.LOG.debug(mfilename, ...
                sprintf("Current buffer holds (%d) complete information blocks", ...
                obj.N_full_blocks));

        end

        function insert_blocks(obj, input_blocks)
            %INSERT_BLOCKS Inserts a given number of input blocks into the internal buffer. Note
            % that the size of the input must be an integer multiple of the minimum block size
            % configured for the buffer.
            %
            %   This method will append the input to the existing contents of the internal buffer.
            %
            %   Input Arguments:
            %
            %     - input_blocks: Array of values to be appended to the object's internal buffer.
            %
            % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
            %
            % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
            % Copyright (c) 2022 Andrés Ferreiro González

            arguments
                obj (1, 1) Buffer
                input_blocks (:, 1)
            end

            sizeMustBeMultipleOf(input_blocks, obj.information_block_size);

            n_blocks = length(input_blocks) / obj.information_block_size;

            obj.LOG.debug(mfilename, ...
                sprintf("Inserting a total of (%d) information blocks in the internal buffer", ...
                n_blocks));

            obj.internal_buffer = [obj.internal_buffer; input_blocks];
            obj.N_full_blocks = floor( ...
                length(obj.internal_buffer) / obj.information_block_size);

            obj.LOG.debug(mfilename, ...
                sprintf("Current buffer holds (%d) complete information blocks", ...
                obj.N_full_blocks));
        end

        function [block_info, last_block_in_buffer] = consume(obj)
            %CONSUME Extracts an information block (of size given the configured information block
            % size) if available. In addition, if the current consumption empties the buffer, it
            % activates a flag.
            %
            %   Output arguments:
            %
            %     - block_info: Extracted information block contents.
            %
            %     - last_block_in_buffer: Flag indicating whether the current operation has emptied
            %       the buffer or not.
            %
            % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
            %
            % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
            % Copyright (c) 2022 Andrés Ferreiro González

            arguments
                obj (1, 1) Buffer
            end

            block_info = [];
            last_block_in_buffer = false;

            if obj.N_full_blocks > 0
                block_info = obj.internal_buffer( ...
                    m_index(0):m_index(obj.information_block_size - 1));
                obj.internal_buffer = obj.internal_buffer(m_index(obj.information_block_size):end);
                last_block_in_buffer = isempty(obj.internal_buffer);

                obj.consumed_counter = obj.consumed_counter + 1;
                obj.N_full_blocks = obj.N_full_blocks - 1;

                obj.LOG.debug(mfilename, ...
                    sprintf("Block %d consumed, there are %d blocks left in buffer", ...
                    obj.consumed_counter, ...
                    obj.N_full_blocks));

            end

        end

        function samples = consume_samples(obj, N)
            %CONSUME_SAMPLES Consumes first N samples from the buffer.
            %
            %   Input Arguments:
            %
            %     - N: Number of individual samples to consume.
            %
            %   Output arguments:
            %
            %     - samples: Consumed number of samples, if available, [] otherwise.
            %
            % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
            %
            % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
            % Copyright (c) 2022 Andrés Ferreiro González

            arguments
                obj (1, 1) Buffer
                N (1, 1) {mustBeInteger, mustBePositive}
            end

            samples = [];

            if length(obj.internal_buffer) >= N
                samples = obj.internal_buffer( ...
                    m_index(0):m_index(N - 1));
                obj.internal_buffer = obj.internal_buffer(m_index(N):end);
                obj.N_full_blocks = floor( ...
                    length(obj.internal_buffer) / obj.information_block_size);
            end

        end

        function is_empty_flag = is_empty(obj)
            %IS_EMPTY Returns true if the buffer is empty, false otherwise.
            %
            %   Output arguments:
            %
            %     - is_empty_flag: Flag indicating whether the internal buffer is empty or not.
            %
            % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
            %
            % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
            % Copyright (c) 2022 Andrés Ferreiro González

            arguments
                obj (1, 1) Buffer
            end

            is_empty_flag = isempty(obj.internal_buffer);
        end

        function stored_blocks_no = n_elem(obj)
            %N_ELEM Returns the size of the input buffer in terms of how many blocks it is currently
            % holding.
            %
            %   Output arguments:
            %
            %     - stored_blocks_no: Number of blocks the internal buffer is currently holding.
            %
            % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
            %
            % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
            % Copyright (c) 2022 Andrés Ferreiro González

            arguments
                obj (1, 1) Buffer
            end

            stored_blocks_no = obj.N_full_blocks;
        end

        function nof_samples_stored = number_of_samples_stored(obj)
            %NUMBER_OF_SAMPLES_STORED Returns the size of the input buffer in terms of how many
            % single items it is currently holding.
            %
            %   Output arguments:
            %
            %     - nof_samples_stored: Number of individual samples the internal buffer is
            %       currently holding.
            %
            % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
            %
            % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
            % Copyright (c) 2022 Andrés Ferreiro González

            arguments
                obj (1, 1) Buffer
            end

            nof_samples_stored = length(obj.internal_buffer);
        end

        function samples = peek(obj, N)
            %PEEK Returns first N samples thhat will be consumed from the buffer next without
            % actually removing them from the buffer.
            %
            %   Input Arguments:
            %
            %     - N: Number of individual samples to peek.
            %
            %   Output arguments:
            %
            %     - samples: Samples peek from the buffer.
            %
            % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
            %
            % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
            % Copyright (c) 2022 Andrés Ferreiro González

            arguments
                obj (1, 1) Buffer
                N (1, 1) {mustBeInteger, mustBePositive}
            end

            samples = [];

            if obj.number_of_samples_stored() >= N
                obj.LOG.trace(mfilename, ...
                    sprintf("Peeking %i samples from buffer (buffer unmodified)", N));
                samples = obj.internal_buffer(m_index(0):m_index(N - 1));
                return
            end

            MSG_STR = "There are no samples to peek in the internal buffer.";
            warning("Buffer:Peek", MSG_STR)
            obj.LOG.warn(mfilename, MSG_STR);
        end

        function reset(obj)
            %RESET Resets the module's delivered block counter and internal buffer.
            %
            % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
            %
            % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
            % Copyright (c) 2022 Andrés Ferreiro González

            arguments
                obj (1, 1) Buffer
            end

            obj.LOG.debug(mfilename, ...
                sprintf( ...
                "Resetting Buffer (%s) contents as requested", ...
                obj.component_identifier));

            obj.consumed_counter = 0;
            obj.N_full_blocks = 0;
            obj.internal_buffer = [];
        end

        function update_information_block_size(obj, information_block_size)
            %UPDATE_information_block_size Updates the configured minimum information block that
            % will be consumed from the buffer. For example, in G2G mode it will be 4096.
            %
            %   Note that this will trigger a reset on the module.
            %
            %   Input Arguments:
            %
            %     - information_block_size: Size of the minimum information block that will be
            %       consumed from the buffer. For example, in G2G mode it will be 4096.
            %
            % Author: Andrés Ferreiro González (andres.ferreiro.glez@gmail.com)
            %
            % Matlab Version: 9.10.0.1851785 (R2021a) Update 6
            % Copyright (c) 2022 Andrés Ferreiro González

            arguments
                obj (1, 1) Buffer
                information_block_size (1, 1) {mustBeInteger, mustBePositive}
            end

            obj.LOG.debug(mfilename, ...
                sprintf( ...
                "Updating Buffer (%s) config as requested", ...
                obj.component_identifier));

            obj.reset();
            obj.information_block_size = information_block_size;

        end

    end

end
