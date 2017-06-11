use std::sync::mpsc::{channel, Sender, Receiver};
use std::thread;
use std::thread::JoinHandle;



fn main() {
    println!("Test Begin");

    let all_zero = vec![vec![0, 0], vec![0, 0], vec![0, 0], vec![0, 0], vec![0, 0], vec![0, 0],
                        vec![0, 0], vec![0, 0], vec![0, 0], vec![0, 0]];
    assert_eq!(bowling_score(&all_zero), 0);

    let all_three = vec![vec![3, 3], vec![3, 3], vec![3, 3], vec![3, 3], vec![3, 3], vec![3, 3],
                         vec![3, 3], vec![3, 3], vec![3, 3], vec![3, 3]];
    assert_eq!(bowling_score(&all_three), 60);

    let all_spares = vec![vec![4, 6],
                          vec![4, 6],
                          vec![4, 6],
                          vec![4, 6],
                          vec![4, 6],
                          vec![4, 6],
                          vec![4, 6],
                          vec![4, 6],
                          vec![4, 6],
                          vec![4, 6, 4]];
    assert_eq!(bowling_score(&all_spares), 140);


    let nine_strikes = vec![vec![10, 0],
                            vec![10, 0],
                            vec![10, 0],
                            vec![10, 0],
                            vec![10, 0],
                            vec![10, 0],
                            vec![10, 0],
                            vec![10, 0],
                            vec![10, 0],
                            vec![0, 0]];
    assert_eq!(bowling_score(&nine_strikes), 240);

    let perfect_game = vec![vec![10, 0],
                            vec![10, 0],
                            vec![10, 0],
                            vec![10, 0],
                            vec![10, 0],
                            vec![10, 0],
                            vec![10, 0],
                            vec![10, 0],
                            vec![10, 0],
                            vec![10, 10, 10]];
    assert_eq!(bowling_score(&perfect_game), 300);


    println!("Test End");
}

fn bowling_score(game: &Vec<Vec<i32>>) -> i32 {
    let sz = game.len();
    let mut agents_handlers: Vec<JoinHandle<()>> = Vec::new();
    let mut agents_senders: Vec<Sender<Vec<i32>>> = Vec::new();
    let (result_sender, result_receiver) = channel::<i32>();
    for frame in game {
        let (agent_handler, agent_sender) = get_agent(result_sender.clone());
        agents_handlers.push(agent_handler);
        agents_senders.push(agent_sender.clone());
        agents_senders.retain(|s| {
                                  let snd_rst = s.send(frame.clone());
                                  snd_rst.is_ok()
                              });
    }
    return result_receiver.iter().take(sz).fold(0, |x, y| x + y);
}

fn get_agent(result_sender: Sender<i32>) -> (JoinHandle<()>, Sender<Vec<i32>>) {
    let (frames_sender, frames_receiver) = channel::<Vec<i32>>();
    let handler = thread::spawn(|| agent_frame_total_score(frames_receiver, result_sender));
    return (handler, frames_sender);
}

fn agent_frame_total_score(in_channel: Receiver<Vec<i32>>, out_channel: Sender<i32>) -> () {
    let mut total_score: i32 = 0;
    let mut is_first = true;
    let mut bonus_rols = 0;
    while is_first || bonus_rols > 0 {
        let frame: &mut Vec<i32> = &mut in_channel.recv().unwrap();
        frame_to_rolls(frame);
        if is_first {
            is_first = false;
            let score = frame.iter().fold(0, |x, y| x + y);
            if score == 10 && frame.len() < 3 {
                bonus_rols = 3 - frame.len();
            }
            total_score += score;
        } else {
            let temp = frame.iter().take(bonus_rols);
            bonus_rols -= temp.len();
            let score = temp.fold(0, |x, y| x + y);
            total_score += score;
        }
    }
    out_channel.send(total_score).unwrap()
}

fn frame_to_rolls(frame: &mut Vec<i32>) -> () {
    if frame.len() == 2 && frame[0] == 10 && frame[1] == 0 {
        frame.remove(1);
    }
}
