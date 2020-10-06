import Foundation

struct Survey : Codable {
    let answers : [Answers]?
    let id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case answers = "answers"
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        answers = try values.decodeIfPresent([Answers].self, forKey: .answers)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}

struct Message : Codable {
    let id : Int?
    let content : Content?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case content = "content"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        content = try values.decodeIfPresent(Content.self, forKey: .content)
    }
    
}

struct Answers : Codable {
    let id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}

struct Author : Codable {
    let id : Int?
    let login : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case login = "login"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        login = try values.decodeIfPresent(String.self, forKey: .login)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
}

struct Content : Codable {
    let markdown : String?
    let html : String?
    
    enum CodingKeys: String, CodingKey {
        
        case markdown = "markdown"
        case html = "html"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        markdown = try values.decodeIfPresent(String.self, forKey: .markdown)
        html = try values.decodeIfPresent(String.self, forKey: .html)
    }
    
}

struct User : Codable {
    let id : Int?
    let login : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        login = try values.decodeIfPresent(String.self, forKey: .login)
    }
    
}

struct Topic : Codable {
    let id : Int?
    let name : String?
    let author : Author?
    let kind : String?
    let created_at : String?
    let updated_at : String?
    let pinned_at : String?
    let locked_at : String?
    let pinner : String?
    let locker : String?
    let messages_url : String?
    let message : Message?
    let survey : Survey?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case author = "author"
        case kind = "kind"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case pinned_at = "pinned_at"
        case locked_at = "locked_at"
        case pinner = "pinner"
        case locker = "locker"
        case messages_url = "messages_url"
        case message = "message"
        case survey = "survey"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        author = try values.decodeIfPresent(Author.self, forKey: .author)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        pinned_at = try values.decodeIfPresent(String.self, forKey: .pinned_at)
        locked_at = try values.decodeIfPresent(String.self, forKey: .locked_at)
        pinner = try values.decodeIfPresent(String.self, forKey: .pinner)
        locker = try values.decodeIfPresent(String.self, forKey: .locker)
        messages_url = try values.decodeIfPresent(String.self, forKey: .messages_url)
        message = try values.decodeIfPresent(Message.self, forKey: .message)
        survey = try values.decodeIfPresent(Survey.self, forKey: .survey)
    }
}

struct MutatingMessage : Codable {
    let author_id : String?
    let content : String?
    let messageable_id : String?
    let messageable_type : String?
    
    enum CodingKeys: String, CodingKey {
        
        case author_id = "author_id"
        case content = "content"
        case messageable_id = "messageable_id"
        case messageable_type = "messageable_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author_id = try values.decodeIfPresent(String.self, forKey: .author_id)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        messageable_id = try values.decodeIfPresent(String.self, forKey: .messageable_id)
        messageable_type = try values.decodeIfPresent(String.self, forKey: .messageable_type)
    }
    
    init(author_id : String?, content : String?, messageable_id : String?, messageable_type : String? = nil) {
        self.author_id = author_id
        self.content = content
        self.messageable_id = messageable_id
        self.messageable_type = messageable_type
    }
    
}

struct createBodyMessage : Codable {
    let message : MutatingMessage?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(MutatingMessage.self, forKey: .message)
    }
    
}

struct Survey_answers_attributes : Codable {
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}

struct Survey_attributes : Codable {
    let name : String?
    let survey_answers_attributes : [Survey_answers_attributes]?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case survey_answers_attributes = "survey_answers_attributes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        survey_answers_attributes = try values.decodeIfPresent([Survey_answers_attributes].self, forKey: .survey_answers_attributes)
    }
    
}

struct Messages_attributes : Codable {
    let author_id : String?
    let content : String?
    let messageable_id : String?
    let messageable_type : String?
    
    enum CodingKeys: String, CodingKey {
        
        case author_id = "author_id"
        case content = "content"
        case messageable_id = "messageable_id"
        case messageable_type = "messageable_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author_id = try values.decodeIfPresent(String.self, forKey: .author_id)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        messageable_id = try values.decodeIfPresent(String.self, forKey: .messageable_id)
        messageable_type = try values.decodeIfPresent(String.self, forKey: .messageable_type)
    }
    
    init(author_id : String?, content : String?,  messageable_id : String? = nil, messageable_type : String? = nil) {
        self.author_id = author_id
        self.content = content
        self.messageable_id = messageable_id
        self.messageable_type = messageable_type
    }
    
}

struct MutatingTopic : Codable {
    let author_id : String?
    let kind : String?
    let language_id : String?
    let messages_attributes : [Messages_attributes]?
    let name : String?
    let tag_ids : [String]?
    let cursus_ids : [String]?
    let survey_attributes : Survey_attributes?
    
    enum CodingKeys: String, CodingKey {
        
        case author_id = "author_id"
        case kind = "kind"
        case language_id = "language_id"
        case messages_attributes = "messages_attributes"
        case name = "name"
        case tag_ids = "tag_ids"
        case cursus_ids = "cursus_ids"
        case survey_attributes = "survey_attributes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author_id = try values.decodeIfPresent(String.self, forKey: .author_id)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        language_id = try values.decodeIfPresent(String.self, forKey: .language_id)
        messages_attributes = try values.decodeIfPresent([Messages_attributes].self, forKey: .messages_attributes)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        tag_ids = try values.decodeIfPresent([String].self, forKey: .tag_ids)
        cursus_ids = try values.decodeIfPresent([String].self, forKey: .cursus_ids)
        survey_attributes = try values.decodeIfPresent(Survey_attributes.self, forKey: .survey_attributes)
    }
    
    init(author_id : String?, kind : String?, language_id : String?, messages_attributes : [Messages_attributes]?, name : String?, tag_ids : [String]? = nil, cursus_ids : [String]? = nil, survey_attributes : Survey_attributes? = nil){
        self.author_id = author_id
        self.kind = kind
        self.language_id = language_id
        self.messages_attributes = messages_attributes
        self.name  = name
        self.tag_ids = tag_ids
        self.cursus_ids = cursus_ids
        self.survey_attributes = survey_attributes
    }
    
}

struct createBodyTopic : Codable {
    let topic : MutatingTopic?
    
    enum CodingKeys: String, CodingKey {
        
        case topic = "topic"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        topic = try values.decodeIfPresent(MutatingTopic.self, forKey: .topic)
    }
    
    init(topic: MutatingTopic) {
        self.topic = topic
    }
    
}

struct TopicMessage : Codable {
    let id : Int?
    let author : Author?
    let content : String?
    let created_at : String?
    let updated_at : String?
    let messageable_id : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case content = "content"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case messageable_id = "messageable_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        author = try values.decodeIfPresent(Author.self, forKey: .author)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        messageable_id = try values.decodeIfPresent(Int.self, forKey: .messageable_id)
    }
}
