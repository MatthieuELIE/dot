require('mini.icons').setup({})

require('mini.pairs').setup({})

require('mini.surround').setup({
    mappings = {
        add = 'gsa',
        delete = 'gsd',
        find = 'gsf',
        find_left = 'gsF',
        highlight = 'gsh',
        replace = 'gsr',
        update_n_lines = 'gsn',
    },
})

require('mini.diff').setup({})

MiniIcons.mock_nvim_web_devicons()
