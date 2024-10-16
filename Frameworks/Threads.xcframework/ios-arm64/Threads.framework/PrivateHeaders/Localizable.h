// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface THRLocalizable : NSObject
/// Нет доступа
+ (NSString*)accessDenied;
/// Поделиться
+ (NSString*)accessoryButtonAccessibilityLabel;
/// Не удалось завершить загрузку файла. Проверьте подключение к интернету
+ (NSString*)attachmentErrorTimeout;
/// аудио файл
+ (NSString*)audioAttachmentTitle;
/// Назад
+ (NSString*)back;
/// Бот
+ (NSString*)bot;
/// На Вашем устройстве не найдена камера
+ (NSString*)cameraNotFound;
/// Отмена
+ (NSString*)cancel;
/// Отмена
+ (NSString*)cancelPick;
/// Не могу сфотографировать
+ (NSString*)cantTakePhoto;
/// Вы
+ (NSString*)clientName;
/// Не удалось загрузить настройки чата
+ (NSString*)connectionToServerConfigError;
/// Истекло время ожидания подключения к серверу
+ (NSString*)connectionToServerTimeoutError;
/// Отменить
+ (NSString*)doCancel;
/// Отправить
+ (NSString*)doSend;
/// Идентификатор клиента не указан
+ (NSString*)emptyClientIdError;
/// Бот
+ (NSString*)externalBot;
/// Удалить
+ (NSString*)failedDelete;
/// Сообщение не было отправлено. Нажмите «повторить отправку», чтобы отправить
+ (NSString*)failedMessage;
/// Повторить отправку
+ (NSString*)failedRetry;
/// 
+ (NSString*)failedTitle;
/// Превышен лимит размера файла. Максимальный размер %.2f мб
+ (NSString*)fileLimitAlertMessageWithValue:(float)p1;
/// Размер файла
+ (NSString*)fileLimitAlertTitle;
/// Отправка файлов запрещена на сервере
+ (NSString*)fileSendingDenied;
/// Файлы
+ (NSString*)files;
/// изображение
+ (NSString*)imageAttachmentTitle;
/// Не удалось открыть ссылку
+ (NSString*)incorrectUrlForOpening;
/// Оператор
+ (NSString*)integration;
/// Вы можете загрузить не более 
+ (NSString*)limitDesc;
/// Лимит достигнут!
+ (NSString*)limitReached;
/// Предыдущие сообщения
+ (NSString*)loadEarlierMessages;
/// Загрузка
+ (NSString*)loadingPlaceholder;
/// новых сообщений
+ (NSString*)manyUnreadMessages;
/// %@: медиа сообщение
+ (NSString*)mediaMessageAccessibilityLabelWithValue:(id)p1;
/// Копировать
+ (NSString*)menuCopyTitle;
/// Цитировать
+ (NSString*)menuQuoteTitle;
/// Ответить
+ (NSString*)menuResponseTitle;
/// Сообщение удалено
+ (NSString*)messageDeleted;
/// Мои альбомы
+ (NSString*)myAlbums;
/// Сообщение
+ (NSString*)newMessage;
/// Получено новое сообщение
+ (NSString*)newMessageReceivedAccessibilityAnnouncement;
/// Нет
+ (NSString*)no;
/// Не доставлено
+ (NSString*)notDelivered;
/// OK
+ (NSString*)ok;
/// новое сообщение
+ (NSString*)oneUnreadMessage;
/// Оператор
+ (NSString*)operator;
/// оператор набирает
+ (NSString*)operatorTyping;
/// Сообщение не может быть пустое
+ (NSString*)outsideTextIsEmpty;
/// Превышен предел длины текста. Максимум %lu символов
+ (NSString*)outsideTextLimitExceedWithValue:(NSInteger)p1;
/// фото
+ (NSString*)photo;
/// Сделать снимок
+ (NSString*)pickPhoto;
/// Отправьте ваш вопрос, первый освободившийся оператор на него ответит.
+ (NSString*)placeholderContent;
/// Добро пожаловать в контакт центр
+ (NSString*)placeholderHeader;
/// Проверьте подключение к сети интернет
+ (NSString*)pleaseCheckYourInternetConnection;
/// Возникла проблема во время инициализации чата:
+ (NSString*)registrationFailedAlert;
/// Повторить
+ (NSString*)repeat;
/// Поиск
+ (NSString*)search;
/// Результатов не найдено
+ (NSString*)searchNotFound;
/// Искать еще
+ (NSString*)searchYetAnother;
/// Отправить
+ (NSString*)send;
/// Отправить
+ (NSString*)sendPhotos;
/// Отправить выбранный файл "%@" в чат?
+ (NSString*)sendSelectedFileToChatAlertWithValue:(id)p1;
/// отправлено в %@
+ (NSString*)sentLabelWithValue:(id)p1;
/// Настройки
+ (NSString*)settings;
/// Подключение...
+ (NSString*)stateConnecting;
/// Отключен
+ (NSString*)stateDisconnected;
/// Загрузка...
+ (NSString*)stateLoadingHistory;
/// Контакт центр
+ (NSString*)stateNotConnected;
/// Контакт центр
+ (NSString*)stateReady;
/// Пожалуйста, подождите...
+ (NSString*)stateWait;
/// Поиск оператора...
+ (NSString*)stateWaitingForSpecialist;
/// Оператор
+ (NSString*)stateWorking;
/// 
+ (NSString*)subTitleErrorCodeFrom400To500;
/// Оператор
+ (NSString*)supervisor;
/// Спасибо за вашу оценку
+ (NSString*)surveyThanks;
/// из
+ (NSString*)surveyVoteFrom;
/// Оператор
+ (NSString*)system;
/// подключилась к диалогу в %@
+ (NSString*)systemMessageJoinChatFemaleWithValue:(id)p1;
/// подключился к диалогу в %@
+ (NSString*)systemMessageJoinChatMaleWithValue:(id)p1;
/// подключился(-ась) к диалогу в %@
+ (NSString*)systemMessageJoinChatUnknownWithValue:(id)p1;
/// покинула диалог в %@
+ (NSString*)systemMessageLeaveChatFemaleWithValue:(id)p1;
/// покинул диалог в %@
+ (NSString*)systemMessageLeaveChatMaleWithValue:(id)p1;
/// покинул(а) диалог в %@
+ (NSString*)systemMessageLeaveChatUnknownWithValue:(id)p1;
/// Текст скопирован в буфер обмена
+ (NSString*)textCopiedToClipboard;
/// %@: %@
+ (NSString*)textMessageAccessibilityLabelWithValues:(id)p1 :(id)p2;
/// Данный чат доступен только для просмотра
+ (NSString*)thisChatIsViewableOnly;
/// Загрузка файла не выполнена.
/// Не удалось проверить файл
+ (NSString*)threadsDisallowedErrorDuringLoadFile;
/// Файл для загрузки не найден
+ (NSString*)threadsFileNotFoundErrorDuringLoadFile;
/// Размер файла превышает допустимое значение
+ (NSString*)threadsFileRestrictedSizeErrorDuringLoadFile;
/// Файл с таким расширением запрещен к загрузке
+ (NSString*)threadsFileRestrictedTypeErrorDuringLoadFile;
/// Неподдерживаемый формат
+ (NSString*)threadsFileUnsupportedFormat;
/// Специалист ответил на все ваши вопросы, продолжить консультацию?
+ (NSString*)threadsRequestCloseThreadText;
/// Произошла ошибка при загрузке
/// или проверке файла
+ (NSString*)threadsSomeErrorDuringLoadFile;
/// Не удалось завершить загрузку файла, истек таймаут.
/// Попробуйте загрузить файл позже
+ (NSString*)threadsTimeoutErrorDuringLoadFile;
/// Не удалось завершить загрузку файла.
/// Попробуйте отправить файл позже
+ (NSString*)threadsUnexpectedErrorDuringLoadFile;
/// Подключиться
+ (NSString*)titleButtonErrorView;
/// Извините за неудобства, чат в данный момент недоступен. Пожалуйста, попробуйте позднее.
+ (NSString*)titleErrorCodeFrom400To500;
/// новых сообщения
+ (NSString*)twoFourUnreadMessages;
/// Разблокируйте доступ к камере в настройках приложения, чтобы продолжить
+ (NSString*)unlockCameraAccess;
/// Разблокируйте доступ к фотографиям в настройках приложения, чтобы продолжить
+ (NSString*)unlockPhotosAccess;
/// Не доставлено
+ (NSString*)validationError;
/// Голосовое сообщение
+ (NSString*)voiceMessage;
/// Запись не читается
+ (NSString*)voicePlayError;
/// Доступ к микрофону запрещен, для записи голосовых сообщений разрешите доступ в настройках
+ (NSString*)voiceRecordingDenied;
/// Удерживайте, чтобы начать запись
+ (NSString*)voiceRecordingHint;
/// Да
+ (NSString*)yes;
@end


NS_ASSUME_NONNULL_END

