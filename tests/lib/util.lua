-------------------------------------------------------------------------------
-- Declaring module
-------------------------------------------------------------------------------
local util = {}

-- Setting up environment
local _ENV = lunit.TEST_CASE "tests.lib.util"

-------------------------------------------------------------------------------
-- Function to check two variables for equality
--
-- @param   expectedVar   The expected variable
-- @param   actualVar     The actual variable
-------------------------------------------------------------------------------
function util.check(expectedVar, actualVar)
  if expectedVar == nil then
    assert_nil(actualVar)
    return
  end
  assert_not_nil(actualVar)
  if expectedVar == true then
    assert_true(actualVar)
    return
  elseif expectedVar == false then
    assert_false(actualVar)
    return
  elseif type(expectedVar) == "number" then
    assert_number(actualVar)
  elseif type(expectedVar) == "string" then
    assert_string(actualVar)
  elseif type(expectedVar) == "table" then
    -- Recursively checking table
    local keys = {}
    for i, v in pairs(expectedVar) do
      util.check(v, actualVar[i])
      keys[i] = true
    end
    for i, v in pairs(actualVar) do
      if not keys[i] then
        fail("Unexpected key: " .. i)
      end
    end
    return
  end
  assert_equal(expectedVar, actualVar)
end

return util
