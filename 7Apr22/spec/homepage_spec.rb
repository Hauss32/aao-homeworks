feature 'App Academy Homepage' do
    scenario 'renders the home page' do
        visit ''
        expect(page).to have_content('Change your career.')
    end

    feature 'has a link to apply to App Academy' do
        background(:each) { visit '' }

        scenario 'apply link exists' do
            expect(page).to have_link('Learn More')
        end

        scenario 'link redirects to learn more page' do
            new_window = window_opened_by { click_link 'Learn More' }
            page.within_window(new_window) do
                expect(page.current_path).to eq('/resource/learn-more')
            end
        end
    end 

    feature 'signing up for the newsletter' do
        background(:each) { visit '' }

        scenario 'has field to sign up for newsletter' do
            expect(page).to have_selector("input[type=submit][value='Register']")
        end

        scenario 'submitting email in newsletter field shows success' do
            fill_in 'Email-subscribe', with: "#{Time.new.to_i}@test.test" 
            click_on 'Register'
            expect(page).to have_text('Success! Thank you for subscribing.')
        end
    end
end