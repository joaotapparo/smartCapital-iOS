import Foundation
import Supabase

final class SupabaseManager {
    static let shared = SupabaseManager()

    let client: SupabaseClient

    private init() {
        let url = URL(string: "https://aeimzsayuggeqccodmvs.supabase.co")!
        let key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFlaW16c2F5dWdnZXFjY29kbXZzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDgzMDAwODgsImV4cCI6MjA2Mzg3NjA4OH0.IUsssZ6b0c-d80Yazkuq7r1Ei4xPAd0vEt4O0NmPDqw"
        client = SupabaseClient(supabaseURL: url, supabaseKey: key)
    }
}
