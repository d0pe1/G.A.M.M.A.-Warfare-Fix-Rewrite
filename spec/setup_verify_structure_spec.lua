
-- Helper to read lines from a file
local function read_lines(path)
  local lines = {}
  local file = assert(io.open(path, 'r'))
  for line in file:lines() do
    if line ~= '' then
      table.insert(lines, line)
    end
  end
  file:close()
  return lines
end

-- Normalize paths by stripping 'old walo/' prefix
local function to_gamma_path(old_path)
  return old_path:gsub('^old walo/', 'gamma_walo/')
end

describe('SETUP-4 verify gamma_walo structure', function()
  it('contains exactly the files listed in docs/old_walo_files.txt', function()
    local expected = {}
    for _, line in ipairs(read_lines('docs/old_walo_files.txt')) do
      local path = to_gamma_path(line)
      expected[#expected+1] = path
    end
    table.sort(expected)

    -- gather actual files
    local actual = {}
    for file in io.popen("find gamma_walo -type f | sort"):lines() do
      actual[#actual+1] = file
    end

    assert.are.same(expected, actual)
  end)
end)

