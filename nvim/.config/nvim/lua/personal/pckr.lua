local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add{
{
	'rose-pine/neovim',
	config = function()
		vim.cmd('colorscheme rose-pine-moon')
	end
};

{
	-- requires 'ripgrep' installed
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	requires = { 'nvim-lua/plenary.nvim' }
};
}

