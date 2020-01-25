protocol DataStore {
  associatedtype T
  associatedtype U
  func save(_ realmObject: T)
  func save(_ realmObjects: [T])
  func load() -> [U]
}
