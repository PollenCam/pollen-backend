require 'spec_helper'

RSpec.describe EventPolicy do
  let!(:policy) { EventPolicy.new(start_time: Time.now) }

  before { Timecop.freeze(policy.start_time) }
  after { Timecop.return }

  describe "#initialization" do
    context "when current time is before start time" do
      it "raises an error" do
        expect { EventPolicy.new(start_time: Time.now + 1) }.to raise_error ArgumentError
      end
    end
  end

  let(:time_after_offset) { offset.from_now }

  describe "#can_upload?" do
    let(:can_upload) { policy.can_upload? }

    context "up to 24 hours after starting the event" do
      it "can upload" do
        expect(can_upload).to be true
      end
    end

    context "just after 24 hours" do
      let(:offset) { 24.hours + 1 }

      it "cannot upload" do
        Timecop.freeze(time_after_offset)
        expect(can_upload).to be false
      end
    end
  end

  describe "#can_download?" do
    let(:can_download) { policy.can_download? }

    context "up to 14 days after starting the event" do
      let(:offset) { 14.days }

      it "can download" do
        Timecop.freeze(time_after_offset)
        expect(can_download).to be true
      end
    end

    context "just after 14 days" do
      let(:offset) { 14.days + 1 }

      context "without payment" do
        it "cannot download" do
          Timecop.freeze(time_after_offset)
          expect(can_download).to be false
        end
      end

      context "with payment" do
        it "can download" do
          policy.payment_at = time_after_offset
          expect(can_download).to be true
        end

        context "after an additional 30 days" do
          it "can download" do
            policy.payment_at = time_after_offset
            Timecop.freeze(time_after_offset + 30.days)
            expect(can_download).to be true
          end
        end

        context "just after the additional 30 days" do
          it "cannot download" do
            policy.payment_at = time_after_offset
            Timecop.freeze(time_after_offset + 30.days + 1)
            expect(can_download).to be false
          end
        end
      end
    end

    context "just after 30 days" do
      let(:offset) { 30.days + 1 }

      it "cannot_download" do
        Timecop.freeze(time_after_offset)
        expect(can_download).to be false
      end

      context "with payment after 30 days" do
        it "cannot download" do
          Timecop.freeze(time_after_offset)
          policy.payment_at = Time.now
          expect(can_download).to be false
        end
      end
    end
  end
end
