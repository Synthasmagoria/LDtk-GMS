#define DerpXmlWrite_LeafElement
/// DerpXMlWrite_LeafElement(tagName, text)
//
//  Writes an element with no children, e.g. <tagName>text</tagName>
//  If you supply '' as text, the empty element syntax will be used, e.g. <tagName/>

var tagName = argument0
var text = argument1

if text != '' {
    DerpXmlWrite_OpenTag(tagName)
    DerpXmlWrite_Text(text)
    DerpXmlWrite_CloseTag()
}
else {
    with objDerpXmlWrite {
        buffer_write(writeBuffer, buffer_text, writeString);
        writeString = '';
        
        if lastWriteType == DERP_XML_TYPE.OPEN_TAG {
            currentIndent += 1
        }
        
        writeString += newlineString
        repeat currentIndent {
            writeString += indentString
        }
        
        writeString += '<'+tagName+'/>'
        lastWriteType = DERP_XML_TYPE.CLOSE_TAG
        lastWriteEmptyElement = true
    }
}

#define DerpXmlWrite_CloseTag
/// DerpXmlWrite_CloseTag()
//
//  Writes a close tag, e.g. </tagname>. DerpXml remembers the name that matches it.

with objDerpXmlWrite {
    if lastWriteType == DERP_XML_TYPE.CLOSE_TAG {
        writeString += newlineString
        currentIndent -= 1
        repeat currentIndent {
            writeString += indentString
        }
    }
    
    var value;
    if ds_stack_size(tagNameStack) > 0 {
        value = ds_stack_pop(tagNameStack)
    }
    else {
        DerpXml_ThrowError("There was no opening tag to this closing tag!")
    }
    writeString += '</'+value+'>'
    lastWriteType = DERP_XML_TYPE.CLOSE_TAG
    lastWriteEmptyElement = false
}

#define DerpXmlWrite_New
/// DerpXmlWrite_New()
//
//  Starts a new empty xml string.

DerpXmlWrite_UnloadBuffer();

with objDerpXmlWrite {
    writeBuffer = buffer_create(1, buffer_grow, 1);
    writeString = ''
    currentIndent = 0
    lastWriteType = DERP_XML_TYPE.START_OF_FILE
    lastWriteEmptyElement = false
}

#define DerpXmlWrite_Config
/// DerpXmlWrite_Config(indentString, newlineString)
//
//  Configures options for writing.
//
//  indentString     String used for indents, default is "  ". Set to "" to disable indents.
//  newlineString    String used for newlines, default is chr(10). Set to "" to disable newlines.

var indentString = argument0
var newlineString = argument1

with objDerpXmlWrite {
    self.indentString = indentString
    self.newlineString = newlineString
}

#define DerpXmlWrite_Text
/// DerpXmlWrite_Text(text)
//
//  Writes text for the middle of an element.

var text = argument0;

with objDerpXmlWrite {
    writeString += text
    lastWriteType = DERP_XML_TYPE.TEXT
    lastWriteEmptyElement = false
}

#define DerpXml_Init
/// DerpXml_Init()
//
//  Initializes DerpXml. Call this once at the start of your game.

enum DERP_XML_TYPE
{
    START_OF_FILE,
    OPEN_TAG,
    CLOSE_TAG,
    TEXT,
    WHITESPACE,
    END_OF_FILE,
    COMMENT
}

if not instance_exists(objDerpXmlWrite) {
    with instance_create(0, 0, objDerpXmlWrite) {
        indentString = '  '
        newlineString = chr(10)
        tagNameStack = ds_stack_create()
        
        writeString = ''
        writeBuffer = -1
        currentIndent = 0
        lastWriteType = DERP_XML_TYPE.START_OF_FILE
        lastWriteEmptyElement = false
    }
}

#define DerpXmlWrite_ToFile
/// DerpXmlWrite_ToFile(path)
var path = argument0;

if (global.__ldtkgms_project_directory == "")
{
    show_debug_message("LDtk error: Couldn't generate room because project directory was not set");
    exit;
}

with (objDerpXmlWrite)
{
    buffer_write(writeBuffer, buffer_text, writeString);
    writeString = '';
    
    buffer_seek(writeBuffer, buffer_seek_start, 0);
    var _f = file_text_open_write_ns(global.__ldtkgms_project_directory + "/datafiles/" + global.__ldtkgms_worlds_directory + "/" + path, -1);
    file_text_write_line_ns(_f, buffer_read(writeBuffer, buffer_text));
    file_text_close_ns(_f);
    buffer_seek(writeBuffer, buffer_seek_end, 0);
}

#define DerpXmlWrite_Attribute
/// DerpXmlWrite_Attribute(key, value)
//
//  Adds an attribute to the open tag that was just written.
//  Call this right after DerpXmlWrite_OpenTag, or DerpXmlWrite_LeafElement with no text.
//
//  <newTag>    -->    <newTag key="value">

var key = argument0
var value = argument1

with objDerpXmlWrite {
    // verify the last added thing was an open tag or empty element
    if lastWriteType != DERP_XML_TYPE.OPEN_TAG and not lastWriteEmptyElement {
        DerpXml_ThrowError("Attributes was added directly after something that wasn't an open tag, empty element, or another attribute!");
    }

    // find appropriate place to insert. one character back if an empty element.
    var insertPos = string_length(writeString)
    if lastWriteEmptyElement {
        insertPos -= 1
    }
    
    var insertString = ' ' + string(key) + '="' + string(value) + '"'
    writeString = string_insert(insertString, writeString, insertPos)
}

#define DerpXml_ThrowError
/// DerpXml_ThrowError(message)
//
//  Causes a runtime error with a certain message.
//  This script is used internally in DerpXml; you shouldn't call it yourself.

var message = argument0

message = 'DerpXml Error: ' + message
show_debug_message(message)
var a = 0;
a += 'DerpXml Error. See the console output for details.'

#define DerpXmlWrite_UnloadBuffer
/// DrpXmlWrite_UnloadBuffer
with (objDerpXmlWrite)
    if (buffer_exists(writeBuffer))
        buffer_delete(writeBuffer);

#define DerpXmlWrite_OpenTag
/// DerpXmlWrite_OpenTag(tagName)
//
//  Writes an open tag, e.g. <tagName>

var tagName = argument0;

with objDerpXmlWrite {
    if lastWriteType == DERP_XML_TYPE.OPEN_TAG {
        currentIndent += 1
    }
    
    writeString += newlineString
    repeat currentIndent {
        writeString += indentString
    }
    
    writeString += '<'+tagName+'>'
    buffer_write(writeBuffer, buffer_text, writeString);
    writeString = '';
    lastWriteType = DERP_XML_TYPE.OPEN_TAG
    ds_stack_push(tagNameStack, tagName)
    lastWriteEmptyElement = false
}

#define DerpXmlWrite_Comment
/// DerpXmlWrite_Comment(commentText)
//
//  Writes a comment element on a new line, e.g. <!--commentText-->

var commentText = argument0

with objDerpXmlWrite {
    if lastWriteType == DERP_XML_TYPE.CLOSE_TAG {
        writeString += newlineString
        repeat currentIndent {
            writeString += indentString
        }
    }
    
    writeString += '<!--'+commentText+'-->'
    lastWriteEmptyElement = false
}
