
local packGrid = {}

local m_tbGrids = {}
local m_maxGridId = 0

packGrid.m_tbUsrData = {}
packGrid.m_statePic = {}

packGrid.eState = {LOCKED=0, EMPTY=1, FILLED_NORMAL=2, FILLED_NEW=3}

function packGrid:getPicByIdx(idx)
  local path = self.m_statePic[idx]
  if path ~= nil then
      if pic ~= nil then
        local pic = nil
        local ret,err = xpcall(function() pic=cc.TextureCache:getInstance().addImage(path) end, function() print(debug.traceback()) end)
        return pic
      else
        return nil
      end
  end
end

function packGrid:setUsrData(data)
  self.m_tbUsrData = clone(data)
  print("userData!")
end

function packGrid:setStatePics(arrPath)
  for _,v in pairs(eState) do
    self.m_statePic[v] = arrPath[v]
  end
end

function packGrid:setGridState(enum)
    local eState = self.eState
    if self.m_rootNode ~= nil then
      local rt = self.m_rootNode
      rt:removeAllChildren()
      --local spriteImg = display.newSprite(self.statePic[enum])
      local spriteImg = cc.Sprite:createWithTexture(self.m_statePic[enum])
      rt:addChild(spriteImg)
    end
end

function packGrid:getGridById(idx)
  if idx > 0 and idx <= m_maxGridId then
    return m_tbGrids[idx]
  else
    return nil
  end
end

function packGrid:bindGird(widget, touchFunc, data)
  local newOne = clone(packGrid)
  newOne.m_rootNode = widget
  local rt = newOne.m_rootNode
  newOne.statePic = {}
  
  newOne:setUsrData(data)
  print(newOne.m_tbUsrData[1])
  
  newOne.touchFunc = touchFunc
  if newOne.touchFunc ~= nil then
    rt:setTouchEnabled(true)
    rt:addTouchEventListener(touchFunc)
  end 
  
  m_maxGridId  = m_maxGridId + 1
  table.insert(m_tbGrids, m_maxGridId, newOne)
  return m_maxGridId
end

function packGrid:clear()
  for k,v in pairs(m_tbGrids) do
    m_tbGrids[k]=nil
  end
  m_maxGridId = 0
  -- table.foreach(self.m_tbGrids, function(k,v) self.m_tbGrids[k]=nil end)
end


return packGrid
