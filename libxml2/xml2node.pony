use "raw/"

class Xml2Node
  var ptr': NullablePointer[XmlNode]
  var ptr: XmlNode
  var allocated: Bool

  new fromPTR(ptrx: NullablePointer[XmlNode])? =>
    if (ptrx.is_none()) then
      error
    else
      ptr' = ptrx
      ptr = ptr'.apply()?
      allocated = true
    end

  fun xpathEval(xpath: String val,  namespaces: Array[(String val, String val)] = []): Xml2XPathResult =>
    let tmpctx: NullablePointer[XmlXPathContext] = LibXML2.xmlXPathNewContext(ptr.doc)
    for (n, url) in namespaces.values() do
      LibXML2.xmlXPathRegisterNs(tmpctx, n, url)
    end
    LibXML2.xmlXPathSetContextNode(ptr', tmpctx)
    let xptr: NullablePointer[XmlXPathObject] = LibXML2.xmlXPathEval(xpath, tmpctx)
    let xpo: Xml2XPathResult = Xml2XPathObject(xptr)
    LibXML2.xmlXPathFreeContext(tmpctx)
    xpo

  fun ref name(): String val =>
    String.from_cstring(ptr.name).clone()

  fun ref getLineNo(): I64 =>
    LibXML2.xmlGetLineNo(ptr')

  fun ref getNodePath(): String =>
    LibXML2.xmlGetNodePath(ptr')

  fun ref xpathCastNodeToString(): String =>
    LibXML2.xmlXPathCastNodeToString(ptr')

  fun ref getProp(pname: String): String =>
		LibXML2.xmlGetProp(ptr', pname)

	fun ref getContent(): String =>
		LibXML2.xmlNodeGetContent(ptr')

	fun ref getLang(): String =>
		LibXML2.xmlNodeGetLang(ptr')

  fun ref castNodeToString(): String =>
    LibXML2.xmlXPathCastNodeToString(ptr')

  fun ref getChildren(): Array[Xml2Node] =>
    var rv: Array[Xml2Node] = Array[Xml2Node]
    var elementCount: U64 = LibXML2.xmlChildElementCount(ptr')

    if (elementCount == 0) then
      return(rv)
    end

    var fptr: NullablePointer[XmlNode] = LibXML2.xmlFirstElementChild(ptr')
    try
      rv.push(Xml2Node.fromPTR(fptr)?)
      while (elementCount > 0) do
        elementCount = elementCount - 1
        fptr = LibXML2.xmlNextElementSibling(fptr)
        rv.push(Xml2Node.fromPTR(fptr)?)
      end
    end
    rv

  fun ref nodeDump(plevel: I32, pformat: I32): String val =>
    var buf: NullablePointer[XmlBuffer] = LibXML2.xmlBufferCreate()
    LibXML2.xmlNodeDump(buf, ptr.doc, ptr', plevel, pformat)
    LibXML2.xmlBufferContent(buf)
