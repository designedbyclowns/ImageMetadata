extension ImageFile: Encodable {
    enum CodingKeys: String, CodingKey {
        case contentType
        case filename
        case fileSize
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(contentType, forKey: .contentType)
        try container.encode(filename, forKey: .filename)
        try container.encodeIfPresent(formattedFileSize, forKey: .fileSize)
    }
}
