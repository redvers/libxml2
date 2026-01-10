use "raw"
use "files"
use "debug"

class Xml2Doc
  let ptr': NullablePointer[XmlDoc]
  let ptr: XmlDoc

  new parseFile(auth: FileAuth, pfilename: String val) ? =>
    let ptrx: NullablePointer[XmlDoc] = LibXML2.xmlParseFile(pfilename)
    ptr' = ptrx
    ptr = ptr'.apply()?

  new parseDoc(pcur: String val) ? =>
    let ptrx: NullablePointer[XmlDoc] = LibXML2.xmlParseDoc(pcur)
    ptr' = ptrx
    ptr = ptr'.apply()?

  fun xpathEval(xpath: String val, namespaces: Array[(String val, String val)] = []): Xml2XPathResult =>
    let tmpctx: NullablePointer[XmlXPathContext] = LibXML2.xmlXPathNewContext(ptr')
    for (n, url) in namespaces.values() do
      LibXML2.xmlXPathRegisterNs(tmpctx, n, url)
    end
    let xptr: NullablePointer[XmlXPathObject] = LibXML2.xmlXPathEval(xpath, tmpctx)
    let xpo: Xml2XPathResult = Xml2XPathObject(xptr)
    LibXML2.xmlXPathFreeContext(tmpctx)
    xpo

  fun ref getRootElement(): Xml2Node ? =>
    let ptrx: NullablePointer[XmlNode] = LibXML2.xmlDocGetRootElement(ptr')
    Xml2Node.fromPTR(ptrx)?

/*
 * DO NOT REENABLE THIS UNTIL WE'VE FOUND A WAY TO ENSURE THAT NO OTHER REFERENCES
 * EXIST IN OUR PROGRAM. THIS HAS TO BE LAST OR ELSE SEGFAULT!
 */
//  fun _final() =>
//    LibXML2.xmlFreeDoc(ptr')
