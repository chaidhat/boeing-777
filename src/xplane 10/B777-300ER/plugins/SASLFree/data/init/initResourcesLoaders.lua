---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
-- MODULES IMAGES LOADER ----------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

-- Special trace logger for resource loading errors
function logResourceErrorStacktrace(...)
    logError(...)
    local currentLevel = 1
    while true do
        local errorInfo = debug.getinfo(currentLevel, "Sl")
        if not errorInfo or errorInfo.what == "C" then break end
        logError(string.format("Resource loading stack trace [%s]:%d", errorInfo.short_src, errorInfo.currentline))
        currentLevel = currentLevel + 1
     end
end

-- Load texture image.
-- Loads image and sets texture coords.  It can be called in forms of:
-- loadImage(fileName) -- sets texture coords to entire texture
-- loadImage(fileName, width, height) -- sets texture coords to show 
--    center part of image.  width and height sets size of image part
-- loadImage(fileName, x, y, width, height) - loads specified part of image
function loadImage(fileName, x, y, width, height)    
    local f = findResourceFile(fileName)
    if f == 0 then 
        logResourceErrorStacktrace("Can't find texture", fileName)
        return nil
    end

    local s
    if height ~= nil then s = sasl.gl.getGLTexture(f, x, y, width, height)
    elseif y ~= nil then s = sasl.gl.getGLTexture(f, x, y)
    else s = sasl.gl.getGLTexture(f) end    
    
    if not s then
        logResourceErrorStacktrace("Can't load texture", fileName)
        return nil
    end
    local h, w = sasl.gl.getTextureSize(s)
    return s, h, w
end

sasl.gl.loadImage = loadImage

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
-- MODULES FONTS LOADERS ----------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

-- Load bitmap font
function loadBitmapFont(fileName)
    return loadFontImpl(fileName, sasl.gl.getGLBitmapFont)
end

sasl.gl.loadBitmapFont = loadBitmapFont

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

-- Load font
function loadFont(fileName)
    return loadFontImpl(fileName, sasl.gl.getGLFont)
end

sasl.gl.loadFont = loadFont

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

-- Load font common implementation
function loadFontImpl(fileName, loadingFunction)
    local f = findResourceFile(fileName)
    if f == 0 then 
        logResourceErrorStacktrace("Can't find font", fileName)
        return nil
    end

    local font = loadingFunction(f)
    if not font then
        logResourceErrorStacktrace("Can't load font", fileName)
    end
    return font
end

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
-- MODULES SOUNDS LOADERS -------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

-- Load sample from file
function loadSample(fileName, needToCreateTimer, needReversed)
    if needToCreateTimer == nil then needToCreateTimer = false end
    if needReversed == nil then needReversed = false end
    
    local f = findResourceFile(fileName)
    if f == 0 then 
        logResourceErrorStacktrace("Can't find sound", fileName)
        return nil
    end

    local s = sasl.al.loadSampleFromFile(f, needToCreateTimer, needReversed)
    if s == nil then
        logResourceErrorStacktrace("Can't load sound", fileName)
        return nil
    end
    return s
end

sasl.al.loadSample = loadSample

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
-- MODULES OBJECTS LOADER ---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

-- Load object from file
function loadObject(fileName)
    local f = findResourceFile(fileName)
    if f == 0 then 
        logResourceErrorStacktrace("Can't find object", fileName)
        return nil
    end

    local o = sasl.loadObjectFromFile(f)
    if o == nil then
        logResourceErrorStacktrace("Can't load object", fileName)
    end
    return o
end

sasl.loadObject = loadObject

-- Load object from file asynchronously
function loadObjectAsync(fileName, callback)
    local f = findResourceFile(fileName)
    if f == 0 then 
        logResourceErrorStacktrace("Can't find object", fileName)
        return nil
    end

    local o = sasl.loadObjectAsyncFromFile(f, callback)
    if o == nil then
        logResourceErrorStacktrace("Can't load object", fileName)
    end
    return o
end

sasl.loadObjectAsync = loadObjectAsync

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
-- MODULES SHADERS LOADER --------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

-- Load shader source from file
function loadShader(shaderID, fileName, shType)
    local f = findResourceFile(fileName)
    if f == 0 then 
        logResourceErrorStacktrace("Can't find shader source", fileName)
        return nil
    end
    
    sasl.gl.addShader(shaderID, f, shType)
end


sasl.gl.loadShader = loadShader
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------