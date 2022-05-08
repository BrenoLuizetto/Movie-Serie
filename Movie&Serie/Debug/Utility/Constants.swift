//
//  HomeConstants.swift
//  Movie&Serie
//
//  Created by Breno Luizetto on 28/06/21.
//

import Foundation

class Constants {
    
    struct OPKeys {
        static let movieOPKey = "api_key=5287ae8d76c11e98a09d2b4dfe0f443e"
    }
    
    struct Url {
        static let imageOriginal = "https://image.tmdb.org/t/p/original"
        static let movieHeader = "https://api.themoviedb.org/3/"
        static let language = "&language=pt-BR"
    }

    struct MovieType {
        static let upcoming = "movie/upcoming?"
        static let topWeek = "trending/all/week?"
        static let genres = "discover/movie?"
        static let genreList = "genre/movie/list?"
        static let favoriteMovies = "favoriteMovies"
    }
    
    struct CellTitle {
        static let upcoming = "Próximos Lançamentos"
        static let topWeek = "Em Alta"
        static let topMovie = "topMovie"
        static let myList = "Minha Lista"
    }
    
    struct Fonts {
        static let kailassaBold = "Kailasa-Bold"
        static let avenirMedium = "Avenir-Medium"
        static let avenirHeavy = "Avenir-Heavy"
        static let avenirBook = "Avenir-Book"
    }
    
    struct CellIdentifier {
        static let movieCollection = "MovieCollectionCell"
        static let movieUpcoming = "MovieUpcomingCell"
        static let topMovie = "TopMovieCell"
        static let movieCell = "MovieCell"
        static let aboutUs = "aboutUsTableViewCell"
    }
    
    struct Labels {
        static let inComing = "Em breve"
        static let back = "Voltar"
        static let username = "Username"
        static let mail = "Email"
        static let password = "Senha"
        static let confirmPassword = "Confirmar Senha"
        static let insertData = "Insira os dados abaixo para prosseguir"
        static let createAccount = "Crie sua conta"
        static let preLoginTitle = "Filmes, séries\n e muito mais,\n sem limites"
        static let preLoginSubTitle = "Assita onde quiser. Cancele\n quando quiser"
        static let begin = "Começar"
        static let start = "Inicio"
        static let appName = "BRCine"
        static let rememberAccess = "Lembrar acesso"
        static let enter = "Entrar"
        static let createAccount2 = "Não possui conta? Cadastre-se"
        static let mailError = "insira um email válido."
        static let loginErrorMessage = "Ops! Ocorreu um erro, verifique suas credenciais e tente novamente"
        static let releases = "Lançamentos"
        static let watch = "Assistir"
        static let myList = "Minha Lista"
        static let knowMore = "Saiba mais"
        static let searchBarText = "Oque você procura"
        static let recommendations = "Recomendações"
        static let removePicture = "Apagar Foto"
        static let takePicture = "Tirar Foto"
        static let choosePicture = "Escolher Foto"
        static let showPicture = "Ver Foto"
        static let cancel = "cancelar"
    }
    
    struct UserDefaults {
        static let favoriteMovies = "FavoriteMovies"
        static let rememberAccess = "RememberAccess"
        static let username = "username"
        static let pass = "pass"
        static let advertisingPreLogin = "advertisingPreLogin"
        static let profileImage = "profileImage"
    }
    
    struct Images {
        static let closeButton = "closeButton"
        static let houseFill = "house.fill"
        static let rectangleFill = "plus.rectangle.on.rectangle.fill"
        static let playFill = "play.fill"
        static let play = "play"
        static let plus = "plus"
        static let infoCircle = "info.circle"
        static let checkmark = "checkmark"
    }
}
