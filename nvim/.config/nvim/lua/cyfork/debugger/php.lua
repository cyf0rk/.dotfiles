local ok, dap = pcall(require, 'dap')
if not ok then return end

dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = {"/home/cyfork/vscode-php-debug/out/phpDebug.js"},
}

dap.configurations.php = {
    {
        name = 'run current script',
        type = 'php',
        request = 'launch',
        port = 9003,
        cwd = '${fileDirname}',
        program = '${file}',
        runtimeExecutable = 'php'
    },
    {
        name = 'Listen for Xdebug',
        type = 'php',
        request = 'launch',
        port = 9003,
    }
}
