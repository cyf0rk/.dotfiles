local chat = require('CopilotChat')
local select = require('CopilotChat.select')
local prompts = require('CopilotChat.prompts')

chat.setup {
    debug = false, -- Enable debug logging
    proxy = nil, -- [protocol://]host[:port] Use this proxy
    allow_insecure = false, -- Allow insecure server connections
    auto_insert_mode = true, -- Automatically enter insert mode when opening window

    system_prompt = prompts.COPILOT_INSTRUCTIONS, -- System prompt to use
    model = 'gpt-4', -- GPT model to use, 'gpt-3.5-turbo' or 'gpt-4'
    temperature = 0.1, -- GPT temperature

    name = 'CopilotChat', -- Name to use in chat
    separator = '---', -- Separator to use in chat
    show_folds = true, -- Shows folds for sections in chat
    show_help = true, -- Shows help message as virtual lines when waiting for user input
    auto_follow_cursor = true, -- Auto-follow cursor in chat
    auto_insert_mode = false, -- Automatically enter insert mode when opening window and if auto follow cursor is enabled on new prompt
    clear_chat_on_new_prompt = false, -- Clears chat on every new prompt

    context = nil, -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
    history_path = vim.fn.stdpath('data') .. '/copilotchat_history', -- Default path to stored history
    callback = nil, -- Callback to use when ask response is received

    -- default selection (visual or line)
    selection = function(source)
        return select.visual(source) or select.line(source)
    end,
    window = {
        layout = 'vertical', -- 'vertical', 'horizontal', 'float'
        -- Options below only apply to floating windows
        relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
        border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
        width = 0.8, -- fractional width of parent
        height = 0.6, -- fractional height of parent
        row = nil, -- row position of the window, default is centered
        col = nil, -- column position of the window, default is centered
        title = 'Copilot Chat', -- title of chat window
        footer = nil, -- footer of chat window
        zindex = 1, -- determines if window is on top or below other floating windows
    },
    mappings = {
        complete = {
            detail = 'Use @<Tab> or /<Tab> for options.',
            insert ='<Tab>',
        },
        close = {
            normal = 'q',
            insert = '<C-c>'
        },
        reset = {
            normal ='<C-\\>',
            insert = '<C-\\>'
        },
        submit_prompt = {
            normal = '<CR>',
            insert = '<C-m>'
        },
        accept_diff = {
            normal = '<C-y>',
            insert = '<C-y>'
        },
        show_diff = {
            normal = 'gd'
        },
        show_system_prompt = {
            normal = 'gp'
        },
        show_user_selection = {
            normal = 'gs'
        },
    }
}

vim.keymap.set({ 'n', 'v' }, '<leader>cco', chat.toggle, { desc = 'CopilotChat Toggle' })
vim.keymap.set("n", "<leader>ccq", function()
    local input = vim.fn.input("Copilot Quick Chat: ")
    if input ~= "" then
        chat.ask(input, { selection = select.buffer })
    end
end)
vim.keymap.set("n", "<leader>cch", function()
    local actions = require('CopilotChat.actions')
    require('CopilotChat.integrations.telescope').pick(actions.help_actions())
end, { desc = 'CopilotChat Help Actions' })
vim.keymap.set("n", "<leader>ccp", function()
    local actions = require('CopilotChat.actions')
    require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
end, { desc = 'CopilotChat Prompt Actions' })
